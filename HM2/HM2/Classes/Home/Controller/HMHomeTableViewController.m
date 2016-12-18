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
#import "UIImageView+WebCache.h"
#import "HMUser.h"
#import "HMStatus.h"
#import "MJExtension.h"
#import "HMLoadMoreFooter.h"
#import "HWLoadMoreFooter.h"

@interface HMHomeTableViewController ()<HMMenuDelegate,UITableViewDataSource>
@property (nonatomic, strong) NSMutableArray *statuses;

@property (nonatomic,assign) BOOL requsetReturn;

@end

@implementation HMHomeTableViewController

-(NSMutableArray *)statuses {
    if (!_statuses) {
        _statuses = [NSMutableArray array];
    }
    return _statuses;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setUpNav];
    //获取用户信息
    [self getUserInfo];
    //下拉刷新
    [self statusesRefresh];
    //上拉刷新
    [self statusesuUpRefresh];
     //获取未读微博数量
    NSTimer *timer= [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setUpUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}
- (void)setUpUnreadCount {
    
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HMAcountModel *account = [HMAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSString *status = [responseObject[@"status"] description];
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        HMLog(@"%@",error);
        
    }];
}
- (void)statusesuUpRefresh {
    HMLoadMoreFooter  *footer = [HMLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}
- (void)statusesRefresh {
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(controlResfresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    //进入刷新程序
    [self controlResfresh:control];
}
- (void)controlResfresh:(UIRefreshControl *)control {
    //那到原来数组中的第一个微博信息
    HMStatus *status = [_statuses firstObject];
    //1.获取账户信息
    HMAcountModel *account = [HMAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    if (status) {
        params[@"since_id"] = status.idstr;
    }
    //2.发送请求
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        //1.字典数组转为模型数组
        NSArray *newStatus = [HMStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //2.将数组中的模型插入到属性数组的最前面
        NSRange range = NSMakeRange(0, newStatus.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuses insertObjects:newStatus atIndexes:set];
        [self.tableView reloadData];
        //结束刷新
        [control endRefreshing];
        //显示加载数量
        [self showNewStatusCount:newStatus.count];
        HMLog(@"-----%@", NSStringFromUIEdgeInsets(self.tableView.contentInset));
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [control endRefreshing];
        HMLog(@"-%@",error);
    }];
}


-(void)showNewStatusCount:(NSUInteger)count {
    UILabel *countLable = [[UILabel alloc] init];
    countLable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    countLable.textColor = [UIColor whiteColor];
    countLable.width = [UIScreen mainScreen].bounds.size.width;
    countLable.height = 40;
    countLable.x = 0;
    countLable.y = 64 - countLable.height;
    if (count == 0) {
        countLable.text = @"没有最新微博数据";
    }else{
        countLable.text = [NSString stringWithFormat:@"为您加载在%lu条数据",(unsigned long)count];
    }
    countLable.textAlignment = NSTextAlignmentCenter;
    [self.navigationController.view insertSubview:countLable belowSubview:self.navigationController.navigationBar];
    int duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        //1.移动y方向可以做动画
//        countLable.y += countLable.height;
        countLable.transform = CGAffineTransformMakeTranslation(0, countLable.height);
    } completion:^(BOOL finished) {
        int interval = 1.0;
        [UIView animateWithDuration:interval  delay:interval options:UIViewAnimationOptionCurveLinear animations:^{
//            countLable.y -= countLable.height;
            countLable.transform = CGAffineTransformIdentity;
        
        } completion:^(BOOL finished) {
            [countLable removeFromSuperview];
        }];
    }];
    
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    HMStatus *status = self.statuses[indexPath.row];
    HMUser *user = status.user;
    
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = user.name;
    cell.detailTextLabel.text = status.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:user.avatar_large] placeholderImage:[UIImage imageNamed:@"avatar_default"]];
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    // 如果tableView还没有数据，就直接返回
    if (self.statuses.count == 0) return;
    //    if ([self.tableView numberOfRowsInSection:0] == 0) return;
    
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        // 加载更多的微博数据
//        HMLog(@"加载更多的微博数据");
        self.requsetReturn = NO;
        [self loadMoreStatus];
    }
    
    /*scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height
     contentInset：除具体内容以外的边框尺寸
     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
     contentOffset:
     1.它可以用来判断scrollView滚动到什么位置
     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
     */
    
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    HMAcountModel *account = [HMAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    HMStatus *lastStatus = [self.statuses lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    // 3.发送请求
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [HMStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statuses addObjectsFromArray:newStatuses];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)
        self.tableView.tableFooterView.hidden = YES;
        [self.tableView setNeedsDisplay];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        HMLog(@"请求失败-%@", error);
        // 结束刷新
        self.tableView.tableFooterView.hidden = YES;
        [self.tableView setNeedsDisplay];
    }];
}


@end
