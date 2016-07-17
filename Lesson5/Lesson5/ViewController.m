//
//  ViewController.m
//  Lesson5
//
//  Created by zhuruhong on 16/7/17.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

//http://www.jianshu.com/p/605858e5bcf3

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    int arrayName[4] = {10, 20, 30, 40};
    /**
     1.(&arrayName + 1)：&arrayName是数组的地址（等价于指向arrayName数组的指针）
     2.增加 1 会往后移动16个字节，开始是4个字节的位置，移动后就是16个字节后面的位置（也就是目前位置是20个字节）
     3.最后又赋值给，int类型的指针p（int类型占4个字节）
     4.所以(p - 1)就是减去4个字节，变成为16个字节的位置，输出的*(p - 1)值为40
     */
    int *p = (int *)(&arrayName + 1);
    NSLog(@"%d", *(p - 1));//输出结果为 40
    
    /**
     1. arrayName 与 &arrayName
     arrayName 是数组名，所以打印出来是数组首元素的地址
     &arrayName 含义就是数组的地址（等价于指向arrayName数组的指针），因为没增加1，所以数组的地址就是数组首元素的地址所以 arrayName <->&arrayName 打印出的地址是一样的
     
     2.（arrayName + 1） 与 （&arrayName + 1）
     （arrayName + 1）通过上述解释我们知道（arrayName + 1）指针是指向int类型，所以内存地址会加上4个字节
     （&arrayName + 1）我们知道&arrayName是数组的地址（等价于指向arrayName数组的指针） 因为增加1，这个数组总共占16个字节，所以内存地址会加上16个字节
     */
    NSLog(@"%p %p", arrayName, arrayName + 1);
    NSLog(@"%p %p", &arrayName, &arrayName + 1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
