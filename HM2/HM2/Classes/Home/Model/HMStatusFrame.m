//
//  HMStatusFrame.m
//  HM2
//
//  Created by 焦起龙 on 16/12/26.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMStatusFrame.h"
#import "HMUser.h"
#import "HMStatus.h"

#define HMStatusCellBorderW 10
#define HMCellMargin 15

@implementation HMStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font
{
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}


- (void)setStatus:(HMStatus *)status {
    
    HMLog(@"-------------------begin--------");
    _status =status;
    HMUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconWH = 35;
    CGFloat iconX = HMStatusCellBorderW;
    CGFloat iconY = HMStatusCellBorderW;
    self.iconImageViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
    CGFloat nameX = CGRectGetMaxX(self.iconImageViewF) + HMStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:HMNameFont];
    self.nameLebleF = (CGRect){{nameX,nameY},nameSize};

    if (status.user.isVip) {//会员大于2 的时候
        CGFloat vipX = CGRectGetMaxX(self.nameLebleF) + HMStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipW = 14;
        CGFloat vipH = nameSize.height;
        self.vipImageViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLebleF) + HMStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:HMTimeFont];
    self.timeLebleF = (CGRect){{timeX,timeY},timeSize};
    
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLebleF) + HMStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:HMTSourceFont];
    self.sourceLebleF = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconImageViewF), CGRectGetMaxY(self.timeLebleF)) + HMStatusCellBorderW;
    CGFloat maxW = cellW - 20;
    CGSize contentSize = [self sizeWithText:status.text font:HMTContentFont maxW:maxW];
    self.contentLebleF = (CGRect){{contentX,contentY},contentSize};
    
    
    
    //计算配图
    CGFloat originalH;
    if (self.status.pic_urls.count) {
        CGFloat photoX = HMStatusCellBorderW;
        CGFloat photoY = CGRectGetMaxY(self.contentLebleF) + HMStatusCellBorderW;
        CGFloat photoW = 100;
        CGFloat photoH = 100;
        self.photoImageViewF = CGRectMake(photoX, photoY, photoW, photoH);
        originalH = CGRectGetMaxY(self.photoImageViewF);
        
    }else{
        originalH = CGRectGetMaxY(self.contentLebleF);
    }
    CGFloat originalX = 0;
    CGFloat originalY = HMCellMargin;
    CGFloat originalW = cellW;
    self.originalViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    
    //计算转发微博
    HMStatus *retweetedStatus = status.retweeted_status;
    HMUser *retweetedUser = retweetedStatus.user;
    //toolBar的y值
    CGFloat toolBarY = 0;
    if (status.retweeted_status) {
        CGFloat retweetedContentX = HMStatusCellBorderW;
        CGFloat retweetedContentY = HMStatusCellBorderW;
        NSString *content = [NSString stringWithFormat:@"@%@ : %@",retweetedUser.name,retweetedStatus.text];
        CGSize retweetedContentSize = [self sizeWithText:content font:HMTRetweetContentFont maxW:cellW - 20];
        self.retweetedContentLableF = (CGRect){retweetedContentX,retweetedContentY,retweetedContentSize};
        
        if (retweetedStatus.pic_urls.count) {
            CGFloat retweetedX = HMStatusCellBorderW;
            CGFloat retweetedH = CGRectGetMaxY(self.retweetedContentLableF) + HMStatusCellBorderW;
            CGFloat retweetedW = 100;
            CGFloat retweetedh = 100;
            self.retweetedPhotoImageViewF = CGRectMake(retweetedX, retweetedH, retweetedW, retweetedh);
            
            self.retweetedViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, CGRectGetMaxY(self.retweetedPhotoImageViewF));
        }else{
            
            self.retweetedViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, CGRectGetMaxY(self.retweetedContentLableF));
        }
        
        
        toolBarY = CGRectGetMaxY(self.retweetedViewF);
        
    }else{
        //cell的高度
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }
    
    //tooBar
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 35.0;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    //cell的高度
    self.height = CGRectGetMaxY(self.toolBarF);
    
    HMLog(@"-------------------end--------");

}
@end
