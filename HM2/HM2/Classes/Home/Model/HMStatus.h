//
//  HMStatus.h
//  HM2
//
//  Created by JLove on 16/12/16.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HMUser;

@interface HMStatus : NSObject
/**	string	字符串型的微博ID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	微博信息内容*/
@property (nonatomic, copy) NSString *text;

/**	object	微博作者的用户信息字段 详细*/
@property (nonatomic, strong) HMUser *user;

/**	object	创建时间*/
@property (nonatomic, copy) NSString *created_at;

/**	object	微博的来源*/
@property (nonatomic,copy) NSString *source;

/**	object	配图数组*/
@property (nonatomic,strong) NSArray *pic_urls;
/** 转发微博*/
@property (nonatomic,strong) HMStatus *retweeted_status;


/**	int	转发数 */
@property (nonatomic,assign) int reposts_count;
/**	int	评论数 */
@property (nonatomic,assign) int comments_count;
/**	int	表态数 */
@property (nonatomic,assign) int attitudes_count;



@end
