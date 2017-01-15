//
//  HMPhotosView.h
//  HM2
//
//  Created by 焦起龙 on 17/1/11.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMPhotosView : UIView
- (void) addImage:(UIImage *)image;
@property (nonatomic,strong, readonly) NSMutableArray *photos;

@end
