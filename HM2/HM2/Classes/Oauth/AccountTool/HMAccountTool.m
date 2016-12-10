//
//  HMAccountTool.m
//  HM2
//
//  Created by 焦起龙 on 16/12/10.
//  Copyright © 2016年 JqlLove. All rights reserved.
// 工具类存取账号信息

/**
 *  @author JqlLove
 *  存储路径
 */
#define AccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]  stringByAppendingString:@"account.archive"]

#import "HMAccountTool.h"
#import "HMAcountModel.h"

@implementation HMAccountTool
+ (void)saveAccount:(HMAcountModel *)account {
    [NSKeyedArchiver archiveRootObject:account toFile:AccountPath];
}
+ (HMAcountModel *)account {
    HMAcountModel *account = [NSKeyedUnarchiver unarchiveObjectWithFile:AccountPath];
    //过期的时间
    NSDate *create_time = [account.create_time dateByAddingTimeInterval:account.expires_in.longLongValue];
    //现在的时间
    NSDate *now = [NSDate date];
    NSComparisonResult result = [create_time compare:now];
   /** NSOrderedAscending 生序, 
       NSOrderedSame, 相等
       NSOrderedDescending 降序
    */
    if (result != NSOrderedDescending) {//过期
        return nil;
    }
    
    return account;
}
@end
