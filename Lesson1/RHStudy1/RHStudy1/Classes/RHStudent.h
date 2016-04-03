//
//  RHStudent.h
//  RHStudy1
//
//  Created by zhuruhong on 16/4/3.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHStudentProtocol.h"

@interface RHStudent : NSObject <RHStudentProtocol>
{
    @public
    NSString *_nickname;
    
    @protected
    NSString *_gender;
    
    @private
    NSString *_password;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *age;

@property (nonatomic, getter=isBest) BOOL best;

- (instancetype)initWithName:(NSString *)aName;
- (void)printData;

@end
