### NSOperation和NSOperationQueue

#### 一、队列及操作
NSOperationQueue有两种不同类型的队列，主队列和自定义队列。

* （1）主队列运行在主线程上。
* （2）自定义队列在后头执行。

队列处理的任务是NSOperation的子类

* （1）NSInvocationOperation
* （2） NSBlockOperation

#### 二、基本使用步骤
定义操作队列
定义操作
将操作添加到队列中

#### 三、demo
（1） NSInvocationOperation（调度操作）

```
- (void) invocationOpertion
{
//定义队列
NSOperationQueue *queue = [[NSOperationQueue alloc] init];

//定义操作并添加到队列
NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operatioAction) object:nil];
[queue addOperation:op];
}

- (void) operatioAction
{
NSLog(@"今天是个好日子！=====%@",[NSThread currentThread]);
}
输出：

2016-04-14 16:41:04.659 OperationTest[28735:1426089] 今天是个好日子！=====<NSThread: 0x7fc7a870b1e0>{number = 2, name = (null)}
总结：可以看出，开启了一个新线程。NSInvocationOperation优点：可以传一个参数，但是需要一个被调度的方法。
```

（2）NSBlockOperation(块操作)

```
- (void) blockOperation
{
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"今天是个好日子=====%@", [NSThread currentThread]);
}];
[queue addOperation:op];
}
总结：块操作比较灵活，代码都在一起，方便使用，方便阅读。
```

（3）设置操作的依赖关系（addDependency）

```
- (void) addDependency
{
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"下载图片1=====%@", [NSThread currentThread]);
}];

NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"下载图片2=====%@", [NSThread currentThread]);
}];

NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"下载图片3=====%@", [NSThread currentThread]);
}];
[op2 addDependency:op1];
[op3 addDependency:op2];
[queue addOperation:op1];
[queue addOperation:op2];
[queue addOperation:op3];
}
输出：

2016-04-14 16:51:41.513 OperationTest[28894:1433850] 下载图片1=====<NSThread: 0x7fa7027045f0>{number = 2, name = (null)}
2016-04-14 16:51:41.515 OperationTest[28894:1433863] 下载图片2=====<NSThread: 0x7fa70241d6c0>{number = 3, name = (null)}
2016-04-14 16:51:41.515 OperationTest[28894:1433863] 下载图片3=====<NSThread: 0x7fa70241d6c0>{number = 3, name = (null)}
总结：添加依赖关系，可以设置操作的执行顺序，否则执行的结果是无序的。但是注意不要出现循环依赖。
```

（4）设置同时并发的线程数量

```
- (void) maxCurrentOperation
{
NSOperationQueue *queue = [[NSOperationQueue alloc] init];
[queue setMaxConcurrentOperationCount:2];
for (int i = 0; i<10; i++) {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"你好====%@", [NSThread currentThread]);
    }];

    [queue addOperation:op];
}
}

优点：设置同时并发线程的数量可以有效的降低CPU的负担和内存开销。
```


