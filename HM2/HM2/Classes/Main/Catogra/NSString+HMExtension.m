//
//  NSString+HMExtension.m
//  HM2
//
//  Created by 焦起龙 on 17/1/5.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "NSString+HMExtension.h"

@implementation NSString (HMExtension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}


@end
