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
@property (nonatomic,weak) HMEmotionList *emotionList;
@property (nonatomic,weak) HMEmotionToolbar *emotionToolbar;


@end
@implementation HMEmotionView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        HMEmotionList *emotionList = [[HMEmotionList alloc] init];
        [self addSubview:emotionList];
        emotionList.backgroundColor = HMRandomColor;
        self.emotionList = emotionList;
        
        HMEmotionToolbar *emotionToolbar = [[HMEmotionToolbar alloc] init];
        [self addSubview:emotionToolbar];
        emotionToolbar.delegate = self;
        self.emotionToolbar = emotionToolbar;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.emotionToolbar.height = 37;
    self.emotionToolbar.width = self.width;
    self.emotionToolbar.x= 0;
    self.emotionToolbar.y = self.height - self.emotionToolbar.height;
    
    self.emotionList.x = self.emotionList.y = 0;
    self.emotionList.width = self.width;
    self.emotionList.height = self.emotionToolbar.y;
}
- (void)emotionToolbar:(HMEmotionToolbar *)toolbar buttonType:(HMEmotionToolbarButtonType)type {
    switch (type) {
        case HMEmotionToolbarButtonTypeDefault:{
            NSLog(@"HMEmotionToolbarButtonTypeDefault");
            NSString *defaultPath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
            NSArray *defaultArr = [NSArray arrayWithContentsOfFile:defaultPath];
            NSLog(@"---%@",defaultArr);

            
            break;
        }
            
        case HMEmotionToolbarButtonTypeRecent:{
            NSLog(@"HMEmotionToolbarButtonTypeRecent");
            
            break;
        }
            
        case HMEmotionToolbarButtonTypeEmoji:{
            NSLog(@"HMEmotionToolbarButtonTypeEmoji");
            NSString *emoPath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
            NSArray *emoArr = [NSArray arrayWithContentsOfFile:emoPath];
            NSLog(@"---%@",emoArr);

            
            break;
        }
            
        case HMEmotionToolbarButtonTypeLxh:{
            NSString *lxhPath = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
            NSArray *lxhArr = [NSArray arrayWithContentsOfFile:lxhPath];
            NSLog(@"---%@",lxhArr);
       
            break;
    
        }
    }
}

@end
