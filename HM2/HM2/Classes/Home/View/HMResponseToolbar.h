//
//  HMResponseToolbar.h
//  HM2
//
//  Created by 焦起龙 on 17/1/10.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,HMToolbarButtonType) {
    HMToolbarButtonTypeCanmera,//拍照
    HMToolbarButtonTypePicture,//相册
    HMToolbarButtonTypeMention, //@
    HMToolbarButtonTypeTrend, // ＃
    HMToolbarButtonTypeEmotion //表情
};
@class HMResponseToolbar;
@protocol HMResponseToolbarDelegate <NSObject>
@optional
- (void)responseToolbar:(HMResponseToolbar *)toolbar didClickedButtonType:(NSUInteger)buttonType;


@end


@interface HMResponseToolbar : UIView
@property (nonatomic,weak) id<HMResponseToolbarDelegate> delegate;
@property (nonatomic,assign) BOOL showKeyboard;

@end
