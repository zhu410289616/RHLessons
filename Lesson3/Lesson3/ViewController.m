//
//  ViewController.m
//  Lesson3
//
//  Created by zhuruhong on 16/7/16.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

//https://github.com/marcuswestin/WebViewJavascriptBridge
//https://github.com/cielpy/CPYJSCoreDemo

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIButton *button;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(50, 80, 150, 60);
    [_button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_button setTitle:@"test" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    //
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 200, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame) - 200)];
    _webView.delegate = self;
    [self.view addSubview:self.webView];
    
    //
    NSString *path = [[NSBundle mainBundle] pathForResource:@"test" ofType:@"html"];
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
    NSString *htmlString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [_webView loadHTMLString:htmlString baseURL:baseURL];
    
}

- (void)buttonAction:(id)sender
{
    if (!self.context) {
        return;
    }
    
    JSValue *funcValue = self.context[@"alertFunc"];
    [funcValue callWithArguments:nil];
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [context setExceptionHandler:^(JSContext *ctx, JSValue *expectValue) {
        NSLog(@"%@", expectValue);
    }];
    
    self.context = context;
    
//    __weak typeof(self) weakSelf = self;
    self.context[@"ocAlert"] = ^{
        
        NSLog(@"ocAlert ...");
        return;
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            __strong typeof(weakSelf) strongSelf = weakSelf;
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"这是OC中的弹框!" preferredStyle:UIAlertControllerStyleAlert];
//            [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [alert dismissViewControllerAnimated:YES completion:^{
//                    
//                }];
//            }]];
//            [strongSelf presentViewController:alert animated:YES completion:nil];
//        });
    };
}

@end
