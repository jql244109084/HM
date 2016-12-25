//
//  HMMyButton.m
//  HM2
//
//  Created by 焦起龙 on 16/12/13.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMMyButton.h"

@implementation HMMyButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.imageView.backgroundColor = [UIColor yellowColor];
        self.titleLabel.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    
    // 1.计算titleLabel的frame
 self.titleLabel.x = 0;
    //self.titleLabel.x = self.imageView.x;

    
    // 2.计算imageView的frame
    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 10;
//    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}
- (void)setFrame:(CGRect)frame  {
frame.size.width += 5;
    
    [super setFrame:frame];
    
    HMLog(@"---%@--",NSStringFromCGRect(frame));
}
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 只要修改了文字，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 只要修改了图片，就让按钮重新计算自己的尺寸
    [self sizeToFit];
}

@end
