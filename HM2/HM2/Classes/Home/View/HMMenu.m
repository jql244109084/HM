
//
//  HMMenu.m
//  HM2
//
//  Created by 焦起龙 on 16/4/24.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMMenu.h"


@interface HMMenu ()

@property (nonatomic,weak) UIImageView *cover;

@end

@implementation HMMenu

-(UIView *)cover{
    
    if (_cover == nil) {
        
        
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.userInteractionEnabled = YES;
        imageView.image = [ UIImage imageNamed:@"popover_background"];
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        imageView.width = 217;
        imageView.height = 200;
        _cover = imageView;
    }
    return _cover;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu{
    
    HMMenu *menu = [[self alloc] init];
    return menu;
}
- (void)showFrom:(UIView *)view{
    
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    self.frame = window.bounds;
   CGRect newRect = [view convertRect:view.bounds toView:nil];
    [window addSubview:self];
    self.cover.y = CGRectGetMaxY(newRect);

    self.cover.x = CGRectGetMidX(newRect) - 217 * 0.5;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

@end
