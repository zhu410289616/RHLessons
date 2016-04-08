//
//  RHStudent.h
//  RHKVODemo
//
//  Created by zhuruhong on 16/4/8.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RHStudent : NSObject
{
    @public
    NSString *_gender;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger weight;

@end
