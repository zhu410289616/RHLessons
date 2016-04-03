//
//  ViewController.m
//  RHStudy1
//
//  Created by zhuruhong on 16/4/2.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize value = _value;
@synthesize string = _stringOther;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _value = @(12);
    [self printText:[NSString stringWithFormat:@"%@", _value]];
    _value = [NSNumber numberWithInt:34];
    [self printText:[NSString stringWithFormat:@"%@", _value]];
    self.value = @(56);
    [self printText:[NSString stringWithFormat:@"%@", _value]];
    
    _stringOther = @"string other";
    [self printText:_stringOther];
    [self printText:self.string];
    self.string = @"string 1";
    [self printText:self.string];
    
    
    _student = [[RHStudent alloc] initWithName:@"zz"];
    [_student printData];
    
    if ([_student conformsToProtocol:@protocol(RHStudentProtocol)]) {
        NSLog(@"RHStudentProtocol");
    }
    
    if ([_student respondsToSelector:@selector(requiredMethodName)]) {
        [_student requiredMethodName];
    }
    
    BOOL best = _student.isBest;
    best = _student.best;
    
    RHStudent *s = [[RHStudent alloc] init];
    s->_nickname = @"c nick name";//c的访问方法
    s.name = [[NSString alloc] initWithFormat:@"%@", @"haha"];
    s.age = @(4);
    [s printData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear...");
    
    NSArray *numberArray = @[@1, @2, @3, @4, @5, @6];
    
    [numberArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"enumerate number: %@", obj);
    }];
    
    for (NSUInteger i=0, numberCount=numberArray.count; i<numberCount; i++) {
        NSLog(@"for number: %@", numberArray[i]);
    }
    
    for (NSNumber *num in numberArray) {
        NSLog(@"for number: %@", num);
    }
    
    NSEnumerator *enumerator = [numberArray objectEnumerator];
    id obj = nil;
    while (obj = [enumerator nextObject]) {
        NSLog(@"enumerate number: %@", obj);
    }
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"viewWillAppear...");
    
    //1. 存入数据
    NSArray *array = @[@"abc",@"d"];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setInteger:123 forKey:@"number"];
    [userDefault setObject:array forKey:@"array"];
    [userDefault synchronize];//存入文件
    
    //2. 取出数据
    NSInteger number = [userDefault integerForKey:@"number"];
    
    NSArray *arrayRead = [userDefault objectForKey:@"array"];
    for (NSString *obj in arrayRead) {
        NSLog(@"item: %@", obj);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSString *)string
//{
//    return _stringOther;
//}
//
//- (void)setString:(NSString *)string
//{
//    //arc 不考虑同步安全
//    _stringOther = string;
//}

+ (void)showSomething
{
    NSLog(@"show some thing");
}

- (void)printText:(NSString *)aText
{
    NSLog(@"print text: %@", aText);
}

- (void)printHelloWorld
{
    [self printText:@"Hello World"];
}

- (IBAction)buttonClick:(id)sender
{
    [self printText:@"button clicked"];
}

@end
