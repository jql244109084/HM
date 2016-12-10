//
//  HMAccountTool.h
//  HM2
//
//  Created by 焦起龙 on 16/12/10.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMAcountModel;

@interface HMAccountTool : NSObject
/**
 *  @author JqlLove
 *  存储账号信息
 *  @param account <#account description#>
 */
+ (void)saveAccount:(HMAcountModel *)account;
+ (HMAcountModel *)account;
@end
