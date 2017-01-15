//
//  HMEmotionToolbar.m
//  HM2
//
//  Created by 焦起龙 on 17/1/14.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMEmotionToolbar.h"
#import "HMResponseButton.h"

@interface HMEmotionToolbar ()
@property (nonatomic,weak) HMResponseButton *selectedBtton;

@end

@implementation HMEmotionToolbar
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.selectedBtton = [self setupBtn:@"默认" buttonType:HMEmotionToolbarButtonTypeDefault];
        [self setupBtn:@"最近" buttonType:HMEmotionToolbarButtonTypeRecent];
        [self setupBtn:@"Emoji" buttonType:HMEmotionToolbarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:HMEmotionToolbarButtonTypeLxh];
    }
    return self;
}
- (HMResponseButton *)setupBtn:(NSString *)title buttonType:(HMEmotionToolbarButtonType)type {
    HMResponseButton *btn = [[HMResponseButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnSelect:) forControlEvents:UIControlEventTouchDown];
    btn.tag = type;
    [self addSubview:btn];
    if (type == HMEmotionToolbarButtonTypeDefault) {
        [self btnSelect:btn];
    }
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selected = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selected = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        
        image = @"compose_emotion_table_right_normal";
        selected = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateDisabled];

    
    return btn;
    
  
    
}
- (void)btnSelect:(HMResponseButton *)button {
    self.selectedBtton.enabled = YES;//原来的设置为yes
    button.enabled = NO;
    self.selectedBtton = button;
    
    if ([self.delegate respondsToSelector:@selector(emotionToolbar:buttonType:)]) {
        [self.delegate emotionToolbar:self buttonType:button.tag];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i<btnCount; i++) {
        HMResponseButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }

}
@end
