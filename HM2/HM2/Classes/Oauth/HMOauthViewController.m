//
//  HMOauthViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/12/9.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMOauthViewController.h"
#import "AFNetworking.h"
#import "HMNewFutureViewController.h"
#import "HMTabBarViewController.h"
#import "HMAcountModel.h"
#import "MBProgressHUD+MJ.h"
#import "HMAccountTool.h"

@interface HMOauthViewController () <UIWebViewDelegate>

@end

@implementation HMOauthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建webview
    UIWebView *webView = [[UIWebView alloc] init];
    webView.frame = self.view.bounds;
    webView.delegate = self;
    [self.view addSubview:webView];
    /**
     * https://api.weibo.com/oauth2/authorize 请求的url
     * client_id	true	string	申请应用时分配的AppKey。
     * redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
     */
    NSString *string = @"https://api.weibo.com/oauth2/authorize?client_id=493606743&redirect_uri=http://";
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *requset = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requset];


}
#pragma mark - webView的代理
- (void)webViewDidStartLoad:(UIWebView *)webView {
//    HMLog(@"%s",__func__);
    [MBProgressHUD showMessage:@"加载中..."];
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    HMLog(@"%s",__func__);
    [MBProgressHUD hideHUD];
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [MBProgressHUD hideHUD];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSLog(@"--%@",url);
    NSRange range = [url rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self getAceessToken:code];
        return NO;//返回no 即不在加载页面
    }
    return YES;
}
- (void)getAceessToken:(NSString *)code {
    /**
    client_id	true	string	申请应用时分配的AppKey。
    client_secret	true	string	申请应用时分配的AppSecret。
    grant_type	true	string	请求的类型，填写authorization_code
    
    grant_type为authorization_code时
    必选	类型及范围	说明
    code	true	string	调用authorize获得的code值。
    redirect_uri	true	string	回调地址，需需与注册应用里的回调地址一致。
     */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"493606743";
    params[@"client_secret"] = @"7a001b5214a97b4febdfc04f17456385";
    params[@"grant_type"] = @"authorization_code";
    params[@"code"] = code;
    params[@"redirect_uri"] = @"http://";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"https://api.weibo.com/oauth2/access_token" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, NSDictionary   * _Nonnull responseObject) {
        [MBProgressHUD hideHUD];
        HMAcountModel *account = [HMAcountModel accountWithDictionary:responseObject];
        //存储自定义的model
        [HMAccountTool saveAccount:account];
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchWindowRootController];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        HMLog(@"-%@",error);
        [MBProgressHUD hideHUD];

    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
