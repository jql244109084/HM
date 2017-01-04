//
//  HMStatusCell.h
//  HM2
//
//  Created by 焦起龙 on 16/12/26.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMStatusFrame;

@interface HMStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong) HMStatusFrame *statusFrame;

@end
