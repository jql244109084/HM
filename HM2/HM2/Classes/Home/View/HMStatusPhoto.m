//
//  HMStatusPhoto.m
//  HM2
//
//  Created by 焦起龙 on 17/1/6.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMStatusPhoto.h"
#import "HMPhoto.h"
#import "HMStatusGifPhotoView.h"


#define HMStatusPhotoWidth 70
#define HMStatusPhotoMargin 10
#define HMStatusPhotoCols(count) ((count == 4) ? 2 : 3)
@implementation HMStatusPhoto

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}
- (void)setPhtots:(NSArray *)phtots {
    _phtots = phtots;
    while (self.subviews.count < phtots.count) {
        HMStatusGifPhotoView *imageViw = [[HMStatusGifPhotoView alloc] init];
        [self addSubview:imageViw];
    }
    
    
    for (int i = 0; i < self.subviews.count; i ++) {
        HMStatusGifPhotoView *imageView = self.subviews[i];
        if (i < phtots.count) {
            imageView.photo = phtots[i];
            imageView.hidden = NO;
        }else{
            imageView.hidden = YES;
        }
    }

}
- (void)layoutSubviews {
    [super layoutSubviews];
    int photoCount = self.phtots.count;
    int countCols = HMStatusPhotoCols(photoCount);
    for (int i = 0;i < photoCount; i ++) {
        HMStatusGifPhotoView *imageView = self.subviews[i];
        //列
        int col = i % countCols;
        imageView.x= (HMStatusPhotoWidth + HMStatusPhotoMargin) * col;
        //行
        int row = i / countCols;
        imageView.y = row * (HMStatusPhotoWidth + HMStatusPhotoMargin);
        imageView.height = HMStatusPhotoWidth;
        imageView.width = HMStatusPhotoWidth;
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count {
    
    //列数
    
    int countCols = HMStatusPhotoCols(count);
    
    int cols = count >= countCols ? countCols : count;
    CGFloat width = HMStatusPhotoWidth * cols + HMStatusPhotoMargin * (cols - 1);
    //行数
    int rows = (count + countCols - 1) / countCols;//第三种
    /** 第一种方法
     rows = count / 3;
     if (rows % 3 != 0) {
     rows = rows + 1;
     }*/
    /** 第二种方法
     if (count % 3 == 0) {
     rows = count / 3;
     }else{
     rows = count / 3 + 1;
     }*/
    
    CGFloat height = HMStatusPhotoWidth * rows + HMStatusPhotoMargin * (rows - 1);
    
    return CGSizeMake(width, height);
}

@end
