//
//  ViewController.m
//  Lesson4
//
//  Created by zhuruhong on 16/7/17.
//  Copyright © 2016年 zhuruhong. All rights reserved.
//

//http://www.jianshu.com/p/1de356637bae

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *mainWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _mainWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _mainWebView.delegate = self;
    [self.view addSubview:_mainWebView];
    
    NSURL *url = [NSURL URLWithString:@"http://www.jianshu.com/p/1de356637bae"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_mainWebView loadRequest:request];
    
    //观察scrollView的contentOffset属性，实现滑动渐变
    [_mainWebView.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if ([object isEqual:_mainWebView.scrollView] && [keyPath isEqualToString:@"contentOffset"]) {
        [self refreshNavigationBar];
    }
}

//refreshNavigationBar中的实现以及切纯色图的方法：
- (void)refreshNavigationBar
{
    // 示例中使用了webView
    CGPoint offset = _mainWebView.scrollView.contentOffset;
    // 通过offset.y与固定值300的比例来决定透明度
    CGFloat alpha = MIN(1, fabs(offset.y/300));
    
    // 设置translucent为NO来消除alpha为1时的系统优化透明
    [self.navigationController.navigationBar setTranslucent:!(BOOL)(int)alpha];
    
    UIColor *realTimeColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:alpha];
    
    UIImage *realTimeImg = [self UINavigationBarImageWithColor:realTimeColor];
    [self.navigationController.navigationBar setBackgroundImage:realTimeImg forBarMetrics:UIBarMetricsDefault];
    // 消除阴影
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

// 获取navigationBar和statusBar的总高度
- (UIImage *)UINavigationBarImageWithColor:(UIColor *)aColor
{
    CGSize navigationBarSize = self.navigationController.navigationBar.frame.size;
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return [self imageWithColor:aColor Size:CGSizeMake(navigationBarSize.width,navigationBarSize.height + statusBarSize.height)];
}

// 绘制纯色图
- (UIImage *)imageWithColor:(UIColor *)aColor Size:(CGSize)aSize
{
    UIGraphicsBeginImageContextWithOptions(aSize, NO, 0);
    [aColor set];
    UIRectFill(CGRectMake(0, 0, aSize.width, aSize.height));
    UIImage *renderedImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return renderedImg;
}

/*
 为了不影响其它页面，记得在离开当前vc的时候将观察去除，将backgroundImage置nil，将默认的透明加上（如果需要的话）。
 [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
 [self.navigationController.navigationBar setShadowImage:nil];
 [self.navigationController.navigationBar setTranslucent:YES];
 [mainWebView.scrollView removeObserver:self forKeyPath:@"contentOffset"];
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSString *docTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.title = docTitle;
}

@end
