//
//  UIBarButtonItem+HMBarButtonItem.h
//  HM2
//
//  Created by 焦起龙 on 16/4/23.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (HMBarButtonItem)
/**
 *  @author JqlLove
 *
 *  @brief 创建导航条的BarButtonItem
 *
 *  @param taget       动作的执行人
 *  @param action      动作
 *  @param image       普通图片
 *  @param heightImage 高亮图片
 *
 *  @return BarButtonItem
 */
+ (UIBarButtonItem *)itemWithTaget:(id)taget action:(SEL)action image:(NSString *)image heightImage:(NSString *)heightImage;
@end
