//
//  ViewController.m
//  RHKVODemo
//
//  Created by zhuruhong on 16/4/8.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "ViewController.h"

//http://blog.csdn.net/eduora_meimei/article/details/44241393
//http://www.jianshu.com/p/37a92141077e
@interface ViewController ()

@end

@implementation ViewController

- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"%@ init", [self class]);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectedViewShow:) name:@"kNotificationViewShow" object:nil];
    }
    return self;
}

- (void)dealloc
{
    [_student removeObserver:self forKeyPath:@"name"];
    [_student removeObserver:self forKeyPath:@"age"];
    [_student removeObserver:self forKeyPath:@"gender"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];
    
    NSLog(@"%@ loadView", [self class]);
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _student = [[RHStudent alloc] init];
    [_student addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_student addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [_student addObserver:self forKeyPath:@"gender" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _valueTextField = [[UITextField alloc] init];
    _valueTextField.frame = CGRectMake(15, 90, 200, 50);
    _valueTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _valueTextField.layer.borderWidth = 0.5f;
    _valueTextField.placeholder = @"请输入姓名";
    [self.view addSubview:_valueTextField];
    
    _enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterButton.frame = CGRectMake(250, 90, 55, 50);
    _enterButton.layer.borderColor = [UIColor blackColor].CGColor;
    _enterButton.layer.borderWidth = 0.5f;
    [_enterButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_enterButton setTitle:@"Enter" forState:UIControlStateNormal];
    [_enterButton addTarget:self action:@selector(doEnterValue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_enterButton];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationViewShow" object:@"可以看到界面了"];
}

- (void)doEnterValue
{
    _student.name = (_valueTextField.text.length > 0) ? _valueTextField.text : @"傻瓜没名字";
    _student.age += 1;
    _student.height += 5;
    _student.weight += 10;
    
    [_student setValue:@"男" forKey:@"gender"];
    [self setValue:@"链式1" forKeyPath:@"_student.name"];
    [self setValue:@"链式2" forKeyPath:@"student.name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"keyPath: %@", keyPath);
    NSLog(@"change: %@, new: %@, old: %@", change, change[@"new"], change[@"old"]);
}

#pragma mark - notification

- (void)detectedViewShow:(NSNotification *)notif
{
    NSLog(@"detectedViewShow: %@", notif);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
