//
//  ViewController.h
//  RHKVODemo
//
//  Created by zhuruhong on 16/4/8.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHStudent.h"

@interface ViewController : UIViewController

@property (nonatomic, strong, readonly) UITextField *valueTextField;
@property (nonatomic, strong, readonly) UIButton *enterButton;

@property (nonatomic, strong) RHStudent *student;

@end

