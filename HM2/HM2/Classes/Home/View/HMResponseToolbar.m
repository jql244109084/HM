//
//  HMResponseToolbar.m
//  HM2
//
//  Created by 焦起龙 on 17/1/10.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMResponseToolbar.h"

@interface HMResponseToolbar ()
@property (nonatomic,weak) UIButton *lastBtn;

@end

@implementation HMResponseToolbar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        [self createButtonImage:@"compose_camerabutton_background" highlighted:@"compose_camerabutton_background_highlighted" buttonType:HMToolbarButtonTypeCanmera];
        [self createButtonImage:@"compose_toolbar_picture" highlighted:@"compose_toolbar_picture_highlighted" buttonType:HMToolbarButtonTypePicture];
        [self createButtonImage:@"compose_trendbutton_background" highlighted:@"compose_trendbutton_background_highlighted" buttonType:HMToolbarButtonTypeTrend];
        [self createButtonImage:@"compose_mentionbutton_background" highlighted:@"compose_mentionbutton_background_highlighted" buttonType:HMToolbarButtonTypeMention];
       
        self.lastBtn = [self createButtonImage:@"compose_keyboardbutton_background" highlighted:@"compose_keyboardbutton_background_highlighted" buttonType:HMToolbarButtonTypeEmotion];
    }
    return self;
}
- (void)setShowKeyboard:(BOOL)showKeyboard {
    _showKeyboard = showKeyboard;
    
    // 默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    // 显示键盘图标
    if (showKeyboard) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    // 设置图片
    [self.lastBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.lastBtn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
}
- (UIButton *)createButtonImage:(NSString *)image highlighted:(NSString *)highlightedImage buttonType:(HMToolbarButtonType)buttonType{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    btn.tag = buttonType;
    [btn addTarget:self action:@selector(buttonClik:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    return btn;
    
}
- (void)layoutSubviews {
    [super layoutSubviews];
    double width = self.width / self.subviews.count;
    for (int i = 0; i < self.subviews.count; i ++) {
        UIButton *btn = self.subviews[i];
        btn.x = width * i;
        btn.y = 0;
        btn.width = width;
        btn.height = self.height;
    }
}
- (void)buttonClik:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(responseToolbar:didClickedButtonType:)]) {
        [self.delegate responseToolbar:self didClickedButtonType:btn.tag];
        
    }
}


@end
