//
//  HMTabBar.m
//  HM2
//
//  Created by 焦起龙 on 16/4/25.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMTabBar.h"
@interface HMTabBar ()



@property (nonatomic,weak) UIButton *plusButton;
@end

@implementation HMTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        UIButton *plusBuuton = [[UIButton alloc] init];
        [plusBuuton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBuuton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        [plusBuuton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal ];
        [plusBuuton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
        [plusBuuton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        plusBuuton.size = plusBuuton.currentBackgroundImage.size;
        [self addSubview:plusBuuton];
        self.plusButton = plusBuuton;
    }
    return self;
}
/**
 *  @author JqlLove
 *
 *  @brief 通知代理
 *
 *  @param button <#button description#>
 */
-(void)btnClick:(UIButton *)button{
    if ([self.delegate respondsToSelector:@selector(tabBar:didClick:)]) {
        [self.delegate tabBar:self didClick:button];
    }
}

/**
 *  @author JqlLove
 *
 *  @brief 系统排完子view 我在排
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.plusButton.centerX = self.size.width * 0.5;
    self.plusButton.centerY = self.size.height * 0.5;
    CGFloat width = self.width / 5;
    int index = 0;
    for (int i = 0;i < self.subviews.count; i++) {
        
        UIView *childView = self.subviews[i];
        Class class = NSClassFromString(@"UITabBarButton");
        if([childView isKindOfClass:class]){
            childView.x = index * width;
            childView.width = width;
            index ++;
            if (index == 2) {
                index ++;
            }
        }
    }
    
    
}

@end
