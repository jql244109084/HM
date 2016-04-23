//
//  HMNavigationViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/23.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMNavigationViewController.h"
#import "UIBarButtonItem+HMBarButtonItem.h"

@interface HMNavigationViewController ()

@end

@implementation HMNavigationViewController

/**
 *  @author JqlLove
 *
 *  @brief 统一设置导航栏的BarButtonItem的字体颜色
 */
+(void)initialize{
    
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[NSForegroundColorAttributeName] = [UIColor orangeColor];
    param[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    
    NSMutableDictionary *paramDisable = [NSMutableDictionary dictionary];
    paramDisable[NSForegroundColorAttributeName] = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0 ];
    paramDisable[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    [item setTitleTextAttributes:param forState:UIControlStateNormal];
    
    [item setTitleTextAttributes:paramDisable forState:UIControlStateDisabled];
    
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
}
/**
 *  @author JqlLove
 *
 *  @brief 自定义导航栏
 *  @拦截push方法
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    if (self.viewControllers.count > 0) {
        UIBarButtonItem *leftleftBarItem = [UIBarButtonItem itemWithTaget:self action:@selector(back) image:@"navigationbar_back" heightImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.leftBarButtonItem = leftleftBarItem;
        
        
        UIBarButtonItem *rightBarItem = [UIBarButtonItem itemWithTaget:self action:@selector(popToMore) image:@"navigationbar_more" heightImage:@"navigationbar_more_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = rightBarItem;
        
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];

}







- (void)back{
#warning self就是HMNavigationControll了 直接pop就行了
    [self popViewControllerAnimated:YES];
}
- (void)popToMore{
    [self popToRootViewControllerAnimated:YES];
}
@end
