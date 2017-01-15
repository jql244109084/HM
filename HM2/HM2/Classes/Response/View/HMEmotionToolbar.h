//
//  HMEmotionToolbar.h
//  HM2
//
//  Created by 焦起龙 on 17/1/14.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMEmotionToolbar;
typedef NS_ENUM(NSUInteger,HMEmotionToolbarButtonType){
    HMEmotionToolbarButtonTypeDefault, //默认
    HMEmotionToolbarButtonTypeRecent, //最近
    HMEmotionToolbarButtonTypeEmoji, //表情
    HMEmotionToolbarButtonTypeLxh, //浪小花

    
};
@protocol HMEmotionToolbarDelegate <NSObject>

@optional
- (void)emotionToolbar:(HMEmotionToolbar *)toolbar buttonType:(HMEmotionToolbarButtonType)type;

@end
@interface HMEmotionToolbar : UIView
@property (nonatomic,weak) id<HMEmotionToolbarDelegate> delegate;
@end
