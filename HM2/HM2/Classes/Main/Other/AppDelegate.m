//
//  AppDelegate.m
//  HM2
//
//  Created by JqlLove on 16/4/20.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "AppDelegate.h"
#import "HMTabBarViewController.h"
#import "HMNewFutureViewController.h"
#import "HMOauthViewController.h"
#import "HMAcountModel.h"
#import "HMAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //设置窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    //显示窗口
    [self.window makeKeyAndVisible];

    //利用HMAccountTool工具拿到账号信息 为空则为过期账号
    HMAcountModel *account = [HMAccountTool account];
    if (account) {//说明之前授权过
        [self.window switchWindowRootController];
    }else {//没有授权过
        self.window.rootViewController = [[HMOauthViewController alloc] init];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    //1.停止下载
    [manager cancelAll];
    //2清楚缓存
    [manager.imageCache clearMemory];
}

@end
