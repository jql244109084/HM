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
#import "HMStatusPhoto.h"

#define HMCellMargin 15


@implementation HMStatusFrame

- (void)setStatus:(HMStatus *)status {
    
    _status =status;
    HMUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconWH = 35;
    CGFloat iconX = HMStatusCellBorderW;
    CGFloat iconY = HMStatusCellBorderW;
    self.iconImageViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    
    CGFloat nameX = CGRectGetMaxX(self.iconImageViewF) + HMStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name  sizeWithFont:HMNameFont];
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
    CGSize timeSize = [status.created_at  sizeWithFont:HMTimeFont];
    self.timeLebleF = (CGRect){{timeX,timeY},timeSize};
    
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLebleF) + HMStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:HMTSourceFont];
    self.sourceLebleF = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconImageViewF), CGRectGetMaxY(self.timeLebleF)) + HMStatusCellBorderW;
    CGFloat maxW = cellW - 20;
    CGSize contentSize = [status.text sizeWithFont:HMTContentFont maxW:maxW];
    self.contentLebleF = (CGRect){{contentX,contentY},contentSize};
    
    
    
    //计算配图
    CGFloat originalH;
    if (self.status.pic_urls.count) {
        CGFloat photoX = HMStatusCellBorderW;
        CGFloat photoY = CGRectGetMaxY(self.contentLebleF) + HMStatusCellBorderW;
        CGSize photosSize = [HMStatusPhoto sizeWithCount:self.status.pic_urls.count];
        self.photoViewF = (CGRect){{photoX, photoY}, photosSize};
        originalH = CGRectGetMaxY(self.photoViewF);
        
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
        CGSize retweetedContentSize = [content sizeWithFont:HMTRetweetContentFont maxW:cellW - 20];
        self.retweetedContentLableF = (CGRect){retweetedContentX,retweetedContentY,retweetedContentSize};
        
        if (retweetedStatus.pic_urls.count) {
            CGFloat retweetedX = HMStatusCellBorderW;
            CGFloat retweetedY = CGRectGetMaxY(self.retweetedContentLableF) + HMStatusCellBorderW;
            
            CGSize retweetedphotosSize = [HMStatusPhoto sizeWithCount:retweetedStatus.pic_urls.count];
            self.retweetedPhotosViewF = (CGRect){{retweetedX, retweetedY}, retweetedphotosSize};
            
            self.retweetedViewF = CGRectMake(0, CGRectGetMaxY(self.originalViewF), cellW, CGRectGetMaxY(self.retweetedPhotosViewF));
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
    self.toolBarF = CGRectMake(toolBarX, toolBarY + HMStatusCellBorderW, toolBarW, toolBarH);
    //cell的高度
    self.height = CGRectGetMaxY(self.toolBarF);
    

}
@end
