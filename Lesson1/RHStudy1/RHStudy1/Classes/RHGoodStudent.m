//
//  RHGoodStudent.m
//  RHStudy1
//
//  Created by zhuruhong on 16/4/3.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHGoodStudent.h"

@implementation RHGoodStudent

- (void)printData
{
    [super printData];
    
    _nickname = @"nick name";
    
    _gender = @"5";
    
//    _password = @"";
}

- (void)setNickName:(NSString *)name
{
    if (_nickname != name) {
        [_nickname release];
        _nickname = [name retain];
    }
}

@end
