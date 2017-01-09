//
//  HMStatusPhoto.h
//  HM2
//
//  Created by 焦起龙 on 17/1/6.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMStatusPhoto : UIView

@property (nonatomic,strong) NSArray *phtots;

+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
