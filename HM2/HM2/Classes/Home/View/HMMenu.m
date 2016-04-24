
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
    
    [window addSubview:self];
    self.cover.y = 30;
    
}


@end
