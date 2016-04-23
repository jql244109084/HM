//
//  UIBarButtonItem+HMBarButtonItem.m
//  HM2
//
//  Created by 焦起龙 on 16/4/23.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "UIBarButtonItem+HMBarButtonItem.h"

@implementation UIBarButtonItem (HMBarButtonItem)

+ (UIBarButtonItem *)itemWithTaget:(id)taget action:(SEL)action image:(NSString *)image heightImage:(NSString *)heightImage
{
    UIButton *leftBarItem = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBarItem setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [leftBarItem setBackgroundImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
    leftBarItem.size = leftBarItem.currentBackgroundImage.size;
    [leftBarItem addTarget:taget action:action forControlEvents:UIControlEventTouchUpInside];
    
   return [[UIBarButtonItem alloc] initWithCustomView:leftBarItem];
    
    
}
@end
