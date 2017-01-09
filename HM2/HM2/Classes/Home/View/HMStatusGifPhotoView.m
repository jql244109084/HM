//
//  HMStatusGifPhotoView.m
//  HM2
//
//  Created by 焦起龙 on 17/1/7.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMStatusGifPhotoView.h"
#import "UIImageView+WebCache.h"
#import "HMPhoto.h"
@interface HMStatusGifPhotoView ()
@property (nonatomic,weak) UIImageView *gif;

@end

@implementation HMStatusGifPhotoView
- (void)setPhoto:(HMPhoto *)photo {
    _photo = photo;
    self.contentMode = UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
    UIImageView *gif = [[UIImageView alloc] initWithImage:image];
    [self addSubview:gif];
    self.gif = gif;
    gif.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.gif.x = self.width - self.gif.width;
    self.gif.y = self.height - self.gif.height;
    
}
@end
