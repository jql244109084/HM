//
//  MHTabBarViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/22.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMTabBarViewController.h"
#import "HMProfileTableViewController.h"
#import "HMHomeTableViewController.h"
#import "HMMessageTableViewController.h"
#import "HMDiscoverTableViewController.h"
#import "HMNavigationViewController.h"
#import "HMTabBar.h"
#import "HMStatusResponseController.h"

@interface HMTabBarViewController ()<HMTabBarDelegate>
@end

@implementation HMTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    //创建添加到tabbar的控制器
    HMHomeTableViewController *home = [[HMHomeTableViewController alloc] init];
    [self addChildViewControllerWithController:home title:@"首页" imageName:@"tabbar_home" selecteImageName:@"tabbar_home_selected"];
    HMMessageTableViewController *message = [[HMMessageTableViewController alloc] init];
    [self addChildViewControllerWithController:message title:@"消息" imageName:@"tabbar_message_center" selecteImageName:@"tabbar_message_center_selected"];
    HMDiscoverTableViewController *discover = [[HMDiscoverTableViewController alloc] init];
    [self addChildViewControllerWithController:discover title:@"发现" imageName:@"tabbar_discover" selecteImageName:@"tabbar_discover_selected"];
    
    HMProfileTableViewController *profile = [[HMProfileTableViewController alloc] init];
    [self addChildViewControllerWithController:profile title:@"我" imageName:@"tabbar_profile" selecteImageName:@"tabbar_profile_selected"];
    
    //替换系统自带的tabBar
    HMTabBar *tabBar = [[HMTabBar alloc] init];
    tabBar.delegate = self;
    
    [self setValue:tabBar forKey:@"tabBar"];
}

/**
 *  @author JqlLove
 *  @brief 导航控制器包装传过来的控制器
 *  @param viewController   要包装的控制器
 *  @param title            导航控制器的标题
 *  @param imageNameString  控制器的常规图片
 *  @param selecteImageName 控制器的选中
 */
-(void)addChildViewControllerWithController:(UIViewController *)viewController title:(NSString *)title imageName:(NSString *)imageNameString selecteImageName:(NSString *)selecteImageName{
    //被包装控制器的属性设置
    viewController.tabBarItem.title = title;
    viewController.navigationItem.title = title;
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = HMColor(123, 123, 123);
    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor orangeColor];
    
    [viewController.tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    [viewController.tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    
//    viewController.view.backgroundColor = HMRandomColor;
    viewController.tabBarItem.image = [UIImage imageNamed:imageNameString];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:selecteImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    //设置导航控制器的根控制器
    HMNavigationViewController *navigationController = [[HMNavigationViewController alloc] initWithRootViewController:viewController];
    //添加到tabar控制器
    [self addChildViewController:navigationController];
    
}

#pragma HMTabBar -- 代理方法

-(void)tabBar:(HMTabBar *)tabBar didClick:(UIButton *)button{
    
    HMStatusResponseController *responseVc = [[HMStatusResponseController alloc] init];
    HMNavigationViewController *nav = [[HMNavigationViewController alloc] initWithRootViewController:responseVc];
    [self  presentViewController:nav animated:YES completion:nil];
}







@end
