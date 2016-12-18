//
//  HMLoadMoreFooter.m
//  HM2
//
//  Created by 焦起龙 on 16/12/18.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMLoadMoreFooter.h"

@implementation HMLoadMoreFooter

+(instancetype)footer{
    return  [[[NSBundle mainBundle] loadNibNamed:@"HMLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
