//
//  HMUser.m
//  HM2
//
//  Created by JLove on 16/12/16.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMUser.h"

@implementation HMUser

- (void)setMbtype:(int)mbtype {
    _mbtype = mbtype;
    self.vip = mbtype > 2;
}

@end
