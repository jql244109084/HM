//
//  HMHomeTableViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/22.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMHomeTableViewController.h"
#import "UIBarButtonItem+HMBarButtonItem.h"
#import "HMMenu.h"
#import "AFNetworking.h"
#import "HMAccountTool.h"
#import "HMMyButton.h"

@interface HMHomeTableViewController ()<HMMenuDelegate>

@end

@implementation HMHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setUpNav];
    //获取用户信息
    [self getUserInfo];
    
}
/**
 *  @author JqlLove
 *
 *  @brief 获取用户信息
 */
- (void)getUserInfo {
    HMAcountModel *account = [HMAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;;
    params[@"uid"] = account.uid;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
        NSString *name = responseObject[@"name"];
        account.name = name;
        [HMAccountTool saveAccount:account];
        //1.重新设置titlebtn的title
        [titleBtn setTitle:name forState:UIControlStateNormal];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        HMLog(@"-%@",error);
    }];
}
/**
 *  @author JqlLove
 *
 *  @brief 设置导航栏
 */
- (void)setUpNav
{
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTaget:self action:@selector(pop) image:@"navigationbar_friendsearch" heightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTaget:self action:@selector(popMore) image:@"navigationbar_pop" heightImage:@"navigationbar_pop_highlighted"];
    
    /* 中间的标题按钮 */
    HMMyButton  *titleButton = [[HMMyButton alloc] init];
    titleButton.width =150;
    titleButton.height = 30;
    // 设置图片和文字
    NSString *name = [HMAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    // 监听标题点击
    [titleButton sizeToFit];
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}
/**
 *  @author JqlLove
 *
 *  @brief 点击标题
 */
- (void)titleClick:(UIButton *)button
{
    HMMenu *dropMenu = [[HMMenu alloc] init];
    dropMenu.delegate = self;
    [dropMenu showFrom:button];
    
    

    
}
#pragma mark －菜单的代理方法
/**
 *  @author JqlLove
 *
 *  @brief 下拉菜单的代理方法
 *
 *  @param menu 传过来显示的菜单
 */
- (void)menuWillShow:(HMMenu *)menu{
    UIButton *button = (UIButton *)self.navigationItem.titleView;
    button.selected = YES;
}
/**
 *  @author JqlLove
 *
 *  @brief 下拉菜单的代理方法
 *
 *  @param menu 传过来显示的菜单
 */
- (void)menuWillDisMiss:(HMMenu *)menu{
    UIButton *button = (UIButton *)self.navigationItem.titleView;
    button.selected = NO;
}
-(void)popMore{
    NSLog(@"----popMore");
}
-(void)pop{
    HMLog(@"----pop");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

@end
