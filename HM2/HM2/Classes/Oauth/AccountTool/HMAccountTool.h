//
//  HMAccountTool.h
//  HM2
//
//  Created by 焦起龙 on 16/12/10.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMAcountModel.h"

@interface HMAccountTool : NSObject
/**
 *  @author JqlLove
 *  存储账号信息
 *  @param account
 */
+ (void)saveAccount:(HMAcountModel *)account;
+ (HMAcountModel *)account;
@end
