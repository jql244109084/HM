//
//  HMStatusFrame.h
//  HM2
//
//  Created by 焦起龙 on 16/12/26.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <Foundation/Foundation.h>
#define HMNameFont [UIFont systemFontOfSize:15]
#define HMTimeFont [UIFont systemFontOfSize:10]
#define HMTSourceFont [UIFont systemFontOfSize:10]
#define HMTContentFont [UIFont systemFontOfSize:15]
//转发微博的文字
#define HMTRetweetContentFont [UIFont systemFontOfSize:13]
#define HMStatusCellBorderW 10

@class HMStatus;

@interface HMStatusFrame : NSObject
@property (nonatomic,strong) HMStatus *status;
//原始微博
@property (nonatomic,assign) CGRect iconImageViewF;
@property (nonatomic,assign) CGRect vipImageViewF;
@property (nonatomic,assign) CGRect photoViewF;
@property (nonatomic,assign) CGRect nameLebleF;
@property (nonatomic,assign) CGRect timeLebleF;
@property (nonatomic,assign) CGRect sourceLebleF;
@property (nonatomic,assign) CGRect contentLebleF;
@property (nonatomic,assign) CGRect originalViewF;

//转发微博
/** 转发背景view */
@property (nonatomic,assign) CGRect retweetedViewF;
/** 转发昵称 ＋ 内容 */
@property (nonatomic,assign) CGRect retweetedContentLableF;
/** 转发配图 */
@property (nonatomic,assign) CGRect retweetedPhotosViewF;


/** 工具条 */
@property (nonatomic,assign) CGRect toolBarF;

/** cell 的高度 */
@property (nonatomic,assign) CGFloat height;
@end
