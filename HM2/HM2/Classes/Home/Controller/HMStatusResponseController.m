//
//  HMStatusResponseController.m
//  HM2
//
//  Created by 焦起龙 on 17/1/8.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMStatusResponseController.h"
#import "HMAccountTool.h"
#import "HMStatusTextView.h"

@interface HMStatusResponseController ()

@end

@implementation HMStatusResponseController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setupTextView];

}
- (void)setupTextView {
    HMStatusTextView *textView = [[HMStatusTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.pleacehoder = @"请分享新鲜事....请分享新鲜事....请分享新鲜事....请分享新鲜事....请分享新鲜事....请分享新鲜事....请分享新鲜事....请分享新鲜事....请分享新鲜事....";
    textView.color = [UIColor grayColor];
    [self.view addSubview:textView];
     
     
}
- (void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [HMAccountTool account].name;
    UILabel *titleView = [[UILabel alloc] init];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.width = 200;
    titleView.height = 35;
    titleView.text = name;
    titleView.numberOfLines = 0;
    self.navigationItem.titleView = titleView;
    
    //设置字体
    NSString *string = [NSString stringWithFormat:@"发微博\n%@",name];
    NSMutableAttributedString *attsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attsString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[string rangeOfString:name]];
    [attsString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[string rangeOfString:name]];
    titleView.attributedText = attsString;
    
}
-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send {
    HMLog(@"%s",__func__);
}
@end
