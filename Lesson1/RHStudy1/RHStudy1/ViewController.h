//
//  ViewController.h
//  RHStudy1
//
//  Created by zhuruhong on 16/4/2.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHStudent.h"

@interface ViewController : UIViewController
{
    IBOutlet UILabel *textLabel;
}

@property (nonatomic, strong) IBOutlet UIImageView *picImageView;

@property (nonatomic, strong) NSNumber *value;
@property (nonatomic, strong) NSString *string;

@property (nonatomic, strong) RHStudent *student;

+ (void)showSomething;
- (void)printText:(NSString *)aText;
- (void)printHelloWorld;

- (IBAction)buttonClick:(id)sender;

@end

