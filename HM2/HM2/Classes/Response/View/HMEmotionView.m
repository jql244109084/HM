//
//  HMEmotionView.m
//  HM2
//
//  Created by 焦起龙 on 17/1/14.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMEmotionView.h"
#import "HMEmotionList.h"
#import "HMEmotionToolbar.h"

@interface HMEmotionView () <HMEmotionToolbarDelegate>
@property (nonatomic,weak) UIView *emotionList;
@property (nonatomic, strong) HMEmotionList *defaultList;
@property (nonatomic, strong) HMEmotionList *recentList;
@property (nonatomic, strong) HMEmotionList *emojiList;
@property (nonatomic, strong) HMEmotionList *lxhList;

@property (nonatomic,weak) HMEmotionToolbar *emotionToolbar;
@end


@implementation HMEmotionView
- (HMEmotionList *)defaultList {
    if (!_defaultList) {
        _defaultList = [[HMEmotionList alloc] init];
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultList.emotions = [NSArray arrayWithContentsOfFile:defaultPath];
        
    }
    return _defaultList;
}
- (HMEmotionList *)recentList {
    if (!_recentList) {
        _recentList = [[HMEmotionList alloc] init];
    }
    return _recentList;
}

- (HMEmotionList *)emojiList {
    if (!_emojiList) {
        _emojiList = [[HMEmotionList alloc] init];
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiList.emotions = [NSArray arrayWithContentsOfFile:defaultPath];
        
    }
    return _emojiList;
}

- (HMEmotionList *)lxhList {
    if (!_lxhList) {
        _lxhList = [[HMEmotionList alloc] init];
        NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhList.emotions = [NSArray arrayWithContentsOfFile:defaultPath];
        
    }
    return _emojiList;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        HMEmotionToolbar *emotionToolbar = [[HMEmotionToolbar alloc] init];
        [self addSubview:emotionToolbar];
        emotionToolbar.delegate = self;
        self.emotionToolbar = emotionToolbar;
        
        UIView *emotionList = [[UIView alloc] init];
        [self addSubview:emotionList];
        self.emotionList = emotionList;
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
    
    // 1.tabbar
    self.emotionToolbar.width = self.width;
    self.emotionToolbar.height = 37;
    self.emotionToolbar.x = 0;
    self.emotionToolbar.y = self.height - self.emotionToolbar.height;
    
    // 2.表情内容
    self.emotionList.x = self.emotionList.y = 0;
    self.emotionList.width = self.width;
    self.emotionList.height = self.emotionToolbar.y;
    
    
    //3.重新计算frame
    NSLog(@"------%@",NSStringFromCGRect(self.emotionToolbar.frame));
}
- (void)emotionToolbar:(HMEmotionToolbar *)toolbar buttonType:(HMEmotionToolbarButtonType)type {
    [self.emotionList.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    switch (type) {
        case HMEmotionToolbarButtonTypeDefault:{
            NSLog(@"HMEmotionToolbarButtonTypeDefault");
            [self.emotionList addSubview:self.defaultList];

            
            break;
        }
            
        case HMEmotionToolbarButtonTypeRecent:{
            NSLog(@"HMEmotionToolbarButtonTypeRecent");
            [self.emotionList addSubview:self.recentList];
            
            break;
        }
            
        case HMEmotionToolbarButtonTypeEmoji:{
            [self.emotionList addSubview:self.emojiList];
            
            break;
        }
            
        case HMEmotionToolbarButtonTypeLxh:{
            [self.emotionList addSubview:self.lxhList];
            break;
    
        }
    }
    //setNeedsLayout 会在适当的时候 调用 layoutsubviews  布局子控件的位置
//    [self setNeedsLayout];
    
    UIView *child = [self.emotionList.subviews lastObject];
    child.frame = self.emotionList.bounds;
}

@end
