//
//  HMStatusTextView.m
//  HM2
//
//  Created by 焦起龙 on 17/1/9.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMStatusTextView.h"

@implementation HMStatusTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [HMNotificationCenter addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}
- (void)textChange {
    [self setNeedsDisplay];
}
- (void)setPleacehoder:(NSString *)pleacehoder {
    _pleacehoder = [pleacehoder copy];
    [self setNeedsDisplay];
}
- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];
}
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    if ([self hasText]) return;
    NSMutableDictionary *atts = [NSMutableDictionary dictionary];
    atts[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    atts[NSForegroundColorAttributeName] = self.color;
    [self.pleacehoder drawInRect:CGRectMake(4, 6, self.width - 8, self.height - 12) withAttributes:atts];
}

@end
