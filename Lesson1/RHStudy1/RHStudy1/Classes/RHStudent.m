//
//  RHStudent.m
//  RHStudy1
//
//  Created by zhuruhong on 16/4/3.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "RHStudent.h"

@implementation RHStudent

- (instancetype)init
{
    if (self = [super init]) {
        _name = [@"rh" retain];
        _age = @(12);
        
        [self addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (instancetype)initWithName:(NSString *)aName
{
    if (self = [super init]) {
        _name = aName;
    }
    return self;
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"name"];
    NSLog(@"[dealloc] _name: %@, _age: %d, retainCount: %ld", _name, [_age intValue], [_name retainCount]);
    [super dealloc];
}

- (void)printData
{
    NSString *tempName = [[NSString alloc] initWithFormat:@"qq"];
    NSLog(@"tempName: %@, %ld", tempName, [tempName retainCount]);
    [tempName release];
    NSLog(@"1 tempName: %@, %ld", tempName, [tempName retainCount]);
    [tempName release];
    NSLog(@"2 tempName: %@, %ld", tempName, [tempName retainCount]);
    
    NSLog(@"_name: %@, _age: %d, retainCount: %ld", _name, [_age intValue], [_name retainCount]);
}

- (void)requiredMethodName
{
    __block int d = 1;
    int(^Sum)(int, int) = ^(int a, int b) {
        d = 2;
        int c = 10;
        return a + b + c;
    };
    NSLog(@"Sum: %d", Sum(1, 5));
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"keyPath: %@, object: %@", keyPath, object);
}

@end
