//
//  HMStatisToolBar.h
//  HM2
//
//  Created by 焦起龙 on 17/1/1.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMStatus;

@interface HMStatusToolBar : UIView
@property (nonatomic,strong) HMStatus *status;
+ (instancetype)toolbar;
@end
