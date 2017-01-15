//
//  HMResponseButton.m
//  HM2
//
//  Created by 焦起龙 on 17/1/14.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMResponseButton.h"

@implementation HMResponseButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    return self;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

@end
