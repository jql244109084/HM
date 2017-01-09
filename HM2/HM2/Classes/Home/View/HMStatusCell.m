//
//  HMStatusCell.m
//  HM2
//
//  Created by 焦起龙 on 16/12/26.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMStatusCell.h"
#import "HMStatusFrame.h"
#import "HMUser.h"
#import "HMStatus.h"
#import "UIImageView+WebCache.h"
#import "HMPhoto.h"
#import "HMStatusToolBar.h"
#import "HMStatusPhoto.h"
//15010337886

@interface HMStatusCell ()
/** 原始微博 */
@property (nonatomic,weak) UIImageView *iconImageView;
@property (nonatomic,weak) UIImageView *vipImageView;

@property (nonatomic,weak) HMStatusPhoto *photosView;
@property (nonatomic,weak) UILabel *nameLeble;
@property (nonatomic,weak) UILabel *timeLeble;
@property (nonatomic,weak) UILabel *sourceLeble;
@property (nonatomic,weak) UILabel *contentLeble;
@property (nonatomic,weak) UIView *originalView;

/** 原始微博 */
@property (nonatomic,weak) UIView *retweetedView;
@property (nonatomic,weak) UILabel *retweetedContentLable;
@property (nonatomic,weak) HMStatusPhoto *retweetedPhotosView;

/** 工具条 */
@property (nonatomic,weak) HMStatusToolBar *toolBarView;

@end

@implementation HMStatusCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    static NSString *ID = @"cell";
    HMStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[HMStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        //设置选中背景颜色－－
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.selectedBackgroundView 
        
        self.backgroundColor = [UIColor whiteColor];
        //原始微博
        [self setUpOriginal];
        //转发微博
        [self setUpRetWeeted];
        //工具条
        [self setUptoolBar];
    }
    return self;
}
- (void)setUptoolBar {
    HMStatusToolBar *toolBarView = [HMStatusToolBar toolbar];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;
}
- (void)setUpRetWeeted {
    
    //转发背景view
    UIView *retweetedView = [[UIView alloc] init];
    [self.contentView addSubview:retweetedView];
    self.retweetedView = retweetedView;
    self.retweetedView.backgroundColor = HMColor(247, 247, 247);
    //转发昵称 ＋ 内容
    UILabel *retweetedContentLable = [[UILabel alloc] init];
    retweetedContentLable.numberOfLines = 0;
    retweetedContentLable.font = HMTRetweetContentFont;
    [retweetedView addSubview:retweetedContentLable];
    self.retweetedContentLable = retweetedContentLable;
    //转发配图
    HMStatusPhoto *retweetedPhotosView = [[HMStatusPhoto alloc] init];
    [retweetedView addSubview:retweetedPhotosView];
    self.retweetedPhotosView = retweetedPhotosView;
}
- (void)setUpOriginal {
    //背景view
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    self.originalView.backgroundColor = [UIColor whiteColor];
    //头像
    UIImageView *iconImageView = [[UIImageView alloc] init];
    [originalView addSubview:iconImageView];
    self.iconImageView = iconImageView;
    
    //vip
    UIImageView *vipImageView = [[UIImageView alloc] init];
    vipImageView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipImageView];
    self.vipImageView = vipImageView;
    
    
    //配图
    HMStatusPhoto *photosView = [[HMStatusPhoto alloc] init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    
    //昵称
    UILabel *nameLeble = [[UILabel alloc] init];
    nameLeble.font = HMNameFont;
    [originalView addSubview:nameLeble];
    self.nameLeble = nameLeble;
    
    
    //时间
    UILabel *timeLeble = [[UILabel alloc] init];
    timeLeble.textColor = [UIColor orangeColor];
    timeLeble.font = HMTimeFont;
    [originalView addSubview:timeLeble];
    self.timeLeble = timeLeble;
    
    
    //来源
    UILabel *sourceLeble = [[UILabel alloc] init];
    sourceLeble.font = HMTSourceFont;
    [originalView addSubview:sourceLeble];
    self.sourceLeble = sourceLeble;
    
    //正文
    UILabel *contentLeble = [[UILabel alloc] init];
    contentLeble.numberOfLines = 0;
    contentLeble.font = HMTContentFont;
    [originalView addSubview:contentLeble];
    self.contentLeble = contentLeble;
    
}
- (void)setStatusFrame:(HMStatusFrame *)statusFrame {
    _statusFrame = statusFrame;
    //取出模型
    HMStatus *status = statusFrame.status;
    HMUser *user = status.user;
//    HMPhoto *photo = status.pic_urls.firstObject;
    
    
    //头像
    self.iconImageView.frame = statusFrame.iconImageViewF;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    //vip
    if (user.isVip) {
        self.vipImageView.hidden = NO;
        self.vipImageView.frame = statusFrame.vipImageViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipImageView.image = [UIImage imageNamed:vipName];
    }else{
        self.vipImageView.hidden = YES;
    }
    
    if (status.pic_urls.count) {
        //配图
        self.photosView.hidden = NO;
        self.photosView.frame = statusFrame.photoViewF;
        self.photosView.phtots = status.pic_urls;
    }else{
        self.photosView.hidden = YES;
    }
    //昵称
    self.nameLeble.frame = statusFrame.nameLebleF;
    self.nameLeble.text = user.name;
    
    //时间
    
    CGFloat timeX = self.nameLeble.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLebleF) + HMStatusCellBorderW;
    CGSize timeSize = [status.created_at  sizeWithFont:HMTimeFont];
    self.timeLeble.frame = (CGRect){{timeX,timeY},timeSize};
    self.timeLeble.text = status.created_at;
    
    
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(statusFrame.timeLebleF) + HMStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HMTSourceFont];
    self.sourceLeble.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLeble.text = status.source;
    
    //内容
    self.contentLeble.frame = statusFrame.contentLebleF;
    self.contentLeble.text = status.text;
    
    self.originalView.frame = statusFrame.originalViewF;
    
    /** 转发微博*/
    HMStatus *retweetedStatus = status.retweeted_status;
    HMUser *retweetedUser = retweetedStatus.user;
    HMPhoto *retweetedPhoto = retweetedStatus.pic_urls.firstObject;
    if (retweetedStatus) {
        self.retweetedView.hidden = NO;
        self.retweetedView.frame = statusFrame.retweetedViewF;
        //转发微博的内容
        self.retweetedContentLable.frame = statusFrame.retweetedContentLableF;
        self.retweetedContentLable.text = [NSString stringWithFormat:@"@%@ : %@",retweetedUser.name,retweetedStatus.text];
        //转发微博的配图
        if(retweetedStatus.pic_urls.count){//有配图
            self.retweetedPhotosView.hidden = NO;
            self.retweetedPhotosView.frame = statusFrame.retweetedPhotosViewF;
            self.retweetedPhotosView.phtots = retweetedStatus.pic_urls;
        }else{
            self.retweetedPhotosView.hidden = YES;
        }
    }else{
        self.retweetedView.hidden = YES;
    }
    
    self.toolBarView.frame = statusFrame.toolBarF;
    
    self.toolBarView.status= status;
}

@end
