//
//  HMTabBar.h
//  HM2
//
//  Created by 焦起龙 on 16/4/25.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>

//代理 协议
@class HMTabBar;
@protocol HMTabBarDelegate <UITabBarDelegate>
@optional
-(void)tabBar:(HMTabBar *)tabBar didClick:(UIButton *)button;
@end

@interface HMTabBar : UITabBar


@property (nonatomic,weak) id<HMTabBarDelegate> delegate;

@end
