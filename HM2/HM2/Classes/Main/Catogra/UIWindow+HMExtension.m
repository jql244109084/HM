//
//  UIWindow+HMExtension.m
//  HM2
//
//  Created by 焦起龙 on 16/12/11.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "UIWindow+HMExtension.h"
#import "HMTabBarViewController.h"
#import "HMNewFutureViewController.h"

@implementation UIWindow (HMExtension)

- (void)switchWindowRootController {
    //从本地读取版本号
    NSString *key = @"CFBundleVersion";
    NSString *lastBundleVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //从plist中读取版本号 升级的时候新特性显示
    NSDictionary *plistDict = [NSBundle mainBundle].infoDictionary;
    NSString *bundleVersion = plistDict[key];
    if ([lastBundleVersion isEqualToString:bundleVersion]) {
        //设置窗口的跟控制器
        HMTabBarViewController *rootController = [[HMTabBarViewController alloc] init];
        self.rootViewController = rootController;
    }else{//不想等就不是同一个版本
        HMNewFutureViewController *newFuture = [[HMNewFutureViewController alloc] init];
        self.rootViewController = newFuture;
        //存储
        [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:key];
    }
}
@end
