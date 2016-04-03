#看懂object-c的符号概念

---
##@, 用于标识一个指令，区别于c和c++的指令
####@interface
####@end
####@implementation
####@property (nonatomic, strong) IBOutlet UILabel *textLabel;
####@property (nonatomic, strong) NSNumber *value;//
####@synthesize value = _value;
####@dynamic value;
####@1, @(12)  等价 [NSNumber numberWithInt:1]
####@"字符串", 
####@[@"abc", @"def"] 等价 [NSArray arrayWithObjects:@"abc", @"def", nil]
####@{@"key1":@"value1", @"key2":@"value2"} 等价 [NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", @"value2", @"key2", nil];

---
## #用于标识c语言中的指令，比如#import或者#define

---
##[], 用于向object-c对象发送消息
####[self methodName];

---
##变量
####IBOutlet UILabel *textLabel;

---
##方法
####+ (NSArray *)getDataList;//加号表示类方法，属于整个类的
####- (void)methodName;//减号表示实例方法类，属于类的某个对象的
####- (void)methodName{}
####- (NSInteger)methodName:(NSString *)param;
####- (NSString *)methodName:(CGFloat)param other:(NSDictionary *)dic;
####- (IBAction)buttonClick:(id)sender;

---
##oc中没有命名空间机制，也没有包的概念，为了区分不同的类，不重名，在类名前加前缀。
####例如：AVFoundtion: NSObject,NSString; UIKit: UIView,UITableView

---
##mrc和arc的编译控制
如果你的工程是开启ARC的, 那就需要对某些文件禁用ARC, (-fno-objc-arc)
如果你的工程是关闭ARC的, 那就需要对某些文件开启ARC.(-fobjc-arc)

---
##生命周期
####UIAppcation
####UIViewController

---
##Categroy

---
##Protocol

---
###NSUserDefaults

//1. 存入数据  
NSArray *array = @[@"abc",@"d"];  
NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];  
[userDefault setInteger:123 forKey:@"number"];  
[userDefault setObject:array forKey:@"array"];  
[userDefault synchronize];//存入文件  
  
//2. 取出数据  
NSInteger number = [userDefault integerForKey:@"number"];  
NSArray *array = [userDefault objectForKey:@"array"]; 




