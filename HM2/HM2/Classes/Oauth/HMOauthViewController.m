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
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    HMLog(@"%s",__func__);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *url = request.URL.absoluteString;
    NSLog(@"--%@",url);
    NSRange range = [url rangeOfString:@"code="];
    if (range.location != NSNotFound) {
        NSUInteger fromIndex = range.location + range.length;
        NSString *code = [url substringFromIndex:fromIndex];
        [self getAceessToken:code];
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
        NSLog(@"--%@",responseObject);
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [doc  stringByAppendingString:@"account.archive"];
        HMAcountModel *account = [HMAcountModel accountWithDictionary:responseObject];
        //存储自定义的model 归档
        [NSKeyedArchiver archiveRootObject:account toFile:path];
        
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        //从本地读取版本号
        NSString *key = @"CFBundleVersion";
        NSString *lastBundleVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
       
        //从plist中读取版本号 升级的时候新特性显示
        NSDictionary *plistDict = [NSBundle mainBundle].infoDictionary;
        NSString *bundleVersion = plistDict[key];
        if ([lastBundleVersion isEqualToString:bundleVersion]) {
            //设置窗口的跟控制器
            HMTabBarViewController *rootController = [[HMTabBarViewController alloc] init];
            window.rootViewController = rootController;
        }else{//不想等就不是同一个版本
            HMNewFutureViewController *newFuture = [[HMNewFutureViewController alloc] init];
            window.rootViewController = newFuture;
            //存储
            [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:key];
        }
        
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        HMLog(@"-%@",error);
    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
