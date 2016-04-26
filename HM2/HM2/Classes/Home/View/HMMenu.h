//
//  HMMenu.h
//  HM2
//
//  Created by 焦起龙 on 16/4/24.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMMenu;
@protocol HMMenuDelegate <NSObject>

@optional
-(void)menuWillDisMiss:(HMMenu *)menu;
-(void)menuWillShow:(HMMenu *)menu;

@end

@interface HMMenu : UIView

+(instancetype)menu;
-(void)showFrom:(UIView *)view;

-(void)menuDismiss;

@property (nonatomic,weak) id<HMMenuDelegate> delegate;

@end
