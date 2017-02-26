//
//  WebViewController.m
//  LoveBird
//
//  Created by User on 2017/1/17.
//  Copyright © 2017年 yu hasing. All rights reserved.
//

#import "WebViewController.h"             //controller
#import "MBProgressHUD+Henry.h"     //view

@interface WebViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

//- (void)webViewDidStartLoad:(UIWebView *)webView{
//    [MBProgressHUD showLoading:@"載入網頁資訊中"];
//}
//- (void)webViewDidFinishLoad:(UIWebView *)webView{
//    [MBProgressHUD hideHUD];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
//    [MBProgressHUD hideHUD];
//}

@end
