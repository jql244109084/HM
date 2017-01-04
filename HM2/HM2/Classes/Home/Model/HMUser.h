//
//  HMUser.h
//  HM2
//
//  Created by JLove on 16/12/16.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMUser : NSObject
/**	string	字符串型的用户UID*/
@property (nonatomic, copy) NSString *idstr;

/**	string	友好显示名称*/
@property (nonatomic, copy) NSString *name;

/**	string	用户头像地址，50×50像素*/
@property (nonatomic, copy) NSString *profile_image_url;

/**	string	用户大头像地址*/
@property (nonatomic,copy) NSString *avatar_large;

/**	string	会员等级*/
@property (nonatomic,assign) int mbrank;
/**	string	会员类型*/
@property (nonatomic,assign) int mbtype;

@property (nonatomic,assign,getter=isVip) BOOL vip;
@end
