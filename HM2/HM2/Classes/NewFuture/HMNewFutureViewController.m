//
//  HMNewFutureViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/27.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMNewFutureViewController.h"
#import "HMTabBarViewController.h"
#define HMPageCount 4

@interface HMNewFutureViewController ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIPageControl *pageControl;

@end

@implementation HMNewFutureViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIScrollView *scrollView = [[UIScrollView alloc ] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    CGFloat scrollViewH = scrollView.size.height;
    CGFloat scrollViewW = scrollView.size.width;
    for (int i = 0; i < HMPageCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc ] init];
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        imageView.width = scrollViewW;
        imageView.height = scrollViewH;
        
        imageView.y = 0;
        imageView.x = scrollViewW * i;
        if (3 == i) {
            [self setupLastImageView:imageView];
        }
        [scrollView addSubview:imageView];
    }
    scrollView.contentSize = CGSizeMake(scrollViewW * HMPageCount, scrollViewH);
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    scrollView.pagingEnabled = YES;
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    pageControl.centerX = scrollViewW * 0.5;
    pageControl.y = scrollViewH - 50;
    pageControl.numberOfPages = HMPageCount;
 
    pageControl.currentPageIndicatorTintColor = [UIColor orangeColor];
    pageControl.pageIndicatorTintColor = HMColor(189,189, 189);
    [pageControl updateCurrentPageDisplay];
    
    

}
- (void)setupLastImageView:(UIImageView *)imageView {
    //1.分享按钮
    imageView.userInteractionEnabled = YES;
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height * 0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleEdgeInsets =  UIEdgeInsetsMake(0, 10, 0, 0);
    [imageView addSubview:shareBtn];
    

    //2.开始微博
    UIButton *startBtn = [[UIButton alloc] init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerY = imageView.height * 0.75;
    startBtn.centerX = shareBtn.centerX;
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startBtn) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:startBtn];
    
    
    
}
- (void)shareClick:(UIButton *)shareBtn {
    shareBtn.selected = !shareBtn.isSelected;
}
/**
 *  @author JqlLove
 *
 *  @brief 开始微博
 */
- (void)startBtn {
   
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[HMTabBarViewController alloc] init];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double offsetX = scrollView.contentOffset.x / self.view.width;
    self.pageControl.currentPage = (int)(offsetX + 0.5);
    
}

@end
