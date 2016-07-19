## iOS 时间响应 和 手势识别

### 一、事件对象
#### 1. UIResponder 响应者对象

简介

* 只有继承了 UIResponder 对象才能 接收 并 处理 事件
UIApplication、UIViewController、UIView 都继承自 UIResponder

处理事件的方法「通过覆盖以下方法实现对事件的处理」

触摸事件

* 有 Began/ Moved/ Ended/ Cancelled 四种「针对 多根 或 一根手指」的事件方法
* 默认的这四种触摸事件 只是将事件传递给上一个响应着「默认上一个响应者是父控件」
* 根据 touches 中 UITouch 的个数可以判断出是单点触摸还是多点触摸
如果两根手指同时触摸 1 个 view，那么 view 只会调用一次 touchesBegan:withEvent: 方法，touches 参数中装着 2 个UITouch 对象
如果这两根手指一前一后分开触摸同一个 view，那么 view 会分别调用 2 次 touchesBegan:withEvent: 方法，并且每次调用时的 touches 参数中只包含 1 个 UITouch 对象
* 部分方法示例：

```
// 一根或者多根手指开始触摸view，系统会自动调用view的下面方法
// Began/ Moved/ Ended/ Cancelled，4 种方法 都是 同一个 event 参数
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event

// 事件 Cancelled 用于 触摸结束前某个系统事件打断触摸过程，系统会自动调用 View下面的 Cancelled 方法
// touches 存放的都是 UITouch 对象
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
```

加速事件

* 有 Began/ Ended/ Cancelled 三种，例如：

```
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event;
```

远程控制事件

```
- (void)remoteControlReceivedWithEvent:(UIEvent *)event;
```

#### 2. UITouch 对象

简介

* 保存手指触摸的相关信息：1 个手指 对应 1 个 UITouch 对象

* 手指触摸屏幕时，创建 1 个与手指关联的 UITouch 对象

* 手指移动时，系统会更新对应的同 1 个 UITouch 对象
* 手指离开屏幕时，系统会销毁相应的 UITouch 对象

> 注：iPhone 开发时，要避免双击事件


属性

```
@property(nonatomic,readonly,retain) UIWindow *window; // 触摸产生时所处的窗口
@property(nonatomic,readonly,retain) UIView *view;     // 触摸产生时所处的视图
@property(nonatomic,readonly) NSUInteger tapCount;     // 短时间内点按屏幕的次数，可用来判断单击、双击或更多的点击
@property(nonatomic,readonly) NSTimeInterval timestamp;// 记录了触摸事件产生或变化时的时间，单位是秒
@property(nonatomic,readonly) UITouchPhase phase;      // 当前触摸事件所处的状态
```

方法

```
// 返回值是 在 View 的坐标系上 当前触摸的位置「中心点的位置」 
// 调用时如果传入 View 参数为 nil，则 返回 相对于 UIWindow 的位置
- (CGPoint)locationInView:(UIView *)view;

// 记录 前一个 触摸位置 
- (CGPoint)previousLocationInView:(UIView *)view;
```

#### 3. UIEvent 对象

简介

* 每 1 个事件就会创建 1 个 UIEvent 对象
* UIEvent 对象用于记录事件产生的 时刻 和 类型


属性

```
@property(nonatomic,readonly) UIEventType type;         // 事件类型
@property(nonatomic,readonly) UIEventSubtype subtype;
@property(nonatomic,readonly) NSTimeInterval timestamp; // 事件产生的时间
```

UIEvent 还提供了相应的方法可以获得在某个 view 上面的触摸对象「UITouch」

#### 4. 示例：UIView 的拖拽

```
// 当手指在 view 上移动的时候「在 UIView 中实现的方法」
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 获取UITouch对象
    UITouch *touch = [touches anyObject];

    // 获取当前点
    CGPoint curP = [touch locationInView:self];
    // 获取上一个点
    CGPoint preP = [touch previousLocationInView:self];

    // 获取x轴偏移量
    CGFloat offsetX = curP.x - preP.x;
    // 获取y轴偏移量
    CGFloat offsetY = curP.y - preP.y;

    // 修改view的位置（frame,center,transform）
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}
```

#### 二、找到发生事件的最合适控件

##### I. 事件的产生过程
1. 系统将发生的事件加入到 UIApplication 管理的 事件队列
2. UIApplication 取出队列的首个事件，将事件分发下去处理，「通常先发送事件给应用程序的主窗口」
3. 在 主窗口在视图结构层次中 找到最适合的视图来处理

##### II. 找到最合适的控件的步骤「HitTest」
找到最合适的控件的步骤，也是 HitTest 的系统实现方法

1. 视图能否 接收事件「是否继承自 UIResponder」
2. 触摸点是否 在视图上面「pointInside 方法返回 YES」
3. 从后往前遍历子控件，重复前面两个步骤
<span style="color:red;">这里说的子控件指：在添加父控件类中添加的子控件，两个控件的类不一定是继承关系</span>


代码模拟

```
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    // 1.判断当前控件能否接收事件，这里 self 指继承自 UIView 的自定义 view
    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) return nil;

    // 2. 判断点在不在当前控件
    if ([self pointInside:point withEvent:event] == NO) return nil;

    // 3.从后往前遍历自己的子控件
    NSInteger count = self.subviews.count;

    for (NSInteger i = count - 1; i >= 0; i--) {
        UIView *childView = self.subviews[i];

        // 把当前控件上的坐标系转换成子控件上的坐标系
        CGPoint childP = [self convertPoint:point toView:childView];

        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) { // 寻找到最合适的view
            return fitView;
        }
    }
    // 循环结束，但表示没有比自己更合适的view
    return self;
}
```

##### III. 注意
在 主窗口在视图结构层次中，事件从 父控件 传递到 子控件「先由上往下 传递」

* 若 父控件不能接收触摸事件，子控件更不能，则 这个父控件的父控件会处理事件
* 若 子控件不能接收触摸事件，事件由子控件 可以接收事件的父控件 处理
* 父控件之外的子控件，能显示，不能处理事件

UIView 的方法

```
// hitTest 的作用：用来寻找最合适的 View
// 调用时刻：当事件传递给控件的时候
// 可以通过更改此函数的返回值，来人为的选取 处理事件的控件
// point：当前的触摸点，point 这个点的坐标系就是方法调用者的坐标系
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event;

// 作用：判断当前触摸点在不在方法调用者「控件」上
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
```

#### 三、事件的处理
响应者链条

* 由多个响应者对象连接起来的链条
* 能很清楚的看见每个响应者之间的联系，并且可以让一个事件多个对象处理「默认一个事件由一个对象处理」

响应顺序

* 若 View 的控制器存在，传递给控制器；若不存在，传给 View 的父视图
* 若视图层次结构的最顶级视图不能处理，则 传递给 Window 对象进行处理
* 若 Window 对象不能处理，则 传递给 UIApplication 对象
* 若 UIApplication 对象不能处理，则 丢弃事件

#### I. 不接受触摸事件的情况
* 不接收用户交互 userInteractionEnabled = NO;
* 隐藏 hidden = YES;「父控件隐藏，子控件也会隐藏」
* 透明 alpha = 0.0 ~ 0.01「父控件透明度变化，子控件透明度也会做相应的变化」

> 注：UIImageView 的 userInteractionEnable 默认是 NO，因此 UIImageView默认不能接收触摸事件

#### II. 事件处理顺序
事件处理顺序，也是 touches 方法 默认处理顺序

1. 调用最合适控件的 touchesBegan/Moved/Ended/Cancelled... 方法
这些 touches 方法 默认将事件顺着响应链条向上传递，交给上一个响应者处理
2. 如果最合适控件调用了 [super touchesBegan/Moved/Ended/Cancelled...];
就会将事件顺 响应者链条 向上传递，传递给上一个响应者处理事件「由下往上 处理」
3. 调用响应者的 touchesBegan/Moved/Ended/Cancelled... 方法

找到上一个响应者的方法

1. 当前 View 是 控制器的 View，则上一个响应者为 控制器
2. 当前 View 不是 控制器的 View，则上一个响应者为 父控件

#### 四、手势识别
没有手势识别时，监听一个 View 上面的触摸事件

* 自定义一个 View
* 实现 View 的 touchesBegan/Moved/Ended/Cancelled... 方法，在方法内部实现具体处理代码


不用手势识别的缺点

* 必须得自定义 View
* 由于是在 View 内部的 touches 方法中监听触摸事件，因此默认情况下，无法让其他外界对象监听 View 的触摸事件
* 不易区分用户的具体手势行为

##### 1. UIGestureRecognizer「抽象类」
简介

* 为了完成手势识别，必须借助于手势识别器 UIGestureRecognizer
* 定义了所有手势的基本行为，使用它的子类才能处理具体的手势

```
UIGestureRecognizer 的子类有：
UITapGestureRecognizer       // 敲击
UIPinchGestureRecognizer     // 捏合，用于缩放
UIPanGestureRecognizer       // 拖拽
UISwipeGestureRecognizer     // 轻扫
UIRotationGestureRecognizer  // 旋转
UILongPressGestureRecognizer // 长按
```

##### 2. 手势识别的状态

```
typedef NS_ENUM(NSInteger, UIGestureRecognizerState) {
    UIGestureRecognizerStatePossible,  // 没有触摸事件发生，所有手势识别的默认状态
    UIGestureRecognizerStateBegan,     // 一个手势已经开始但尚未改变或者完成时
    UIGestureRecognizerStateChanged,   // 手势状态改变
    UIGestureRecognizerStateEnded,     // 手势完成
    UIGestureRecognizerStateCancelled, // 手势取消，恢复至Possible状态
    UIGestureRecognizerStateFailed,    // 手势失败，恢复至Possible状态
    // 识别到手势识别
    UIGestureRecognizerStateRecognized = UIGestureRecognizerStateEnded
};
```

##### 3. 使用步骤 
每一个手势识别器的用法都差不多，比如 UITapGestureRecognizer 的使用步骤如下

```
// 1. 创建手势识别器对象
UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];

// 2. 设置手势识别器对象的具体属性
//    连续敲击 2 次
tap.numberOfTapsRequired = 2;
//    需要 2 根手指一起敲击
tap.numberOfTouchesRequired = 2;

// 3. 「如果必要」手势是可以设置代理的，要遵守 UIGestureRecognizerDelegate 协议
tap.delegate = self;

// 4. 添加手势识别器到对应的view上
[self.iconView addGestureRecognizer:tap];

// 5. 监听手势的触发
[tap addTarget:self action:@selector(tapIconView:)];
```

手势的常用代理方法

```
// 是否允许开始触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer

// 是否允许同时支持多个手势，默认是不支持多个手势「Yes 表示支持多个手势」
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer

// 是否允许接收手指的触摸点「可以控制一个 View 只有部分能够点击」
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
```


