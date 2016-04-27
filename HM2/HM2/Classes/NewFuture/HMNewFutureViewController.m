//
//  HMNewFutureViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/27.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMNewFutureViewController.h"
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double offsetX = scrollView.contentOffset.x / self.view.width;
    
    self.pageControl.currentPage = (int)(offsetX + 0.5);
    
}

@end
