//
//  HMStatisToolBar.m
//  HM2
//
//  Created by 焦起龙 on 17/1/1.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMStatusToolBar.h"
#import "HMStatus.h"
@interface HMStatusToolBar ()
@property (nonatomic,strong) NSMutableArray *btns;
@property (nonatomic,strong) NSMutableArray *dividers;


@property (nonatomic,weak) UIButton *repost;//转发
@property (nonatomic,weak) UIButton *comment; //评论
@property (nonatomic,weak) UIButton *attitude;//点赞

@end

@implementation HMStatusToolBar

- (NSMutableArray *)btns {
    if (_btns == nil) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
- (NSMutableArray *)dividers {
    if (!_dividers) {
        _dividers = [NSMutableArray array];
    }
    return _dividers;
}
+ (instancetype)toolbar {
    HMStatusToolBar *toobar = [[self alloc] init];
    return toobar;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
       
        self.comment =  [self setUpBtnTitle:@"评论" icon:@"timeline_icon_comment"];
        self.attitude = [self setUpBtnTitle:@"赞" icon:@"timeline_icon_unlike"];
        self.repost = [self setUpBtnTitle:@"转发" icon:@"timeline_icon_retweet"];
        
        //设置分割线
        [self setUpDividers];
        [self setUpDividers];
    }
    return self;
}
- (void)setUpDividers{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    
    [self.dividers addObject:divider];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    //按钮
    int conut = self.btns.count;
    CGFloat btnW = self.width / 3;
    CGFloat btnH = self.height;
    for (int i = 0; i < conut; i ++) {
        UIButton *btn = self.btns[i];
        btn.x = btnW * i;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    for (int i = 0; i < self.dividers.count;i++) {
        UIImageView *imageView = self.dividers[i];
        imageView.x = btnW * (i + 1) + 1;
        imageView.y = 0;
        imageView.width = 1;
        imageView.height = btnH;
        
    }
}
- (UIButton *)setUpBtnTitle:(NSString *)title icon:(NSString *)icon {
    UIButton *btn = [[UIButton alloc] init];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}
-(void)setStatus:(HMStatus *)status {
    _status = status;
    [self setupBtnCount:status.reposts_count button:self.repost titile:@"转发"];
    [self setupBtnCount:status.comments_count button:self.comment titile:@"评论"];
    [self setupBtnCount:status.attitudes_count button:self.attitude titile:@"赞"];
    
}
- (void)setupBtnCount:(int)count button:(UIButton *)btn titile:(NSString *)title {
//    count = 123232;
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }else{
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
            
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}
@end
