//
//  HMNavigationViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/23.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMNavigationViewController.h"

@interface HMNavigationViewController ()

@end

@implementation HMNavigationViewController

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
        UIButton *leftBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [leftBarItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_back"] forState:UIControlStateNormal];
        [leftBarItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_back_highlighted"] forState:UIControlStateHighlighted];
        leftBarItem.size = leftBarItem.currentBackgroundImage.size;
        [leftBarItem addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBarItem];
        
        UIButton *rightBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
        [rightBarItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_more"] forState:UIControlStateNormal];
        [rightBarItem setBackgroundImage:[UIImage imageNamed:@"navigationbar_more_highlighted"] forState:UIControlStateHighlighted];
        rightBarItem.size = rightBarItem.currentBackgroundImage.size;
        [rightBarItem addTarget:self action:@selector(popToMore) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarItem];
        
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
