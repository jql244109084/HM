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

@interface HMHomeTableViewController ()<HMMenuDelegate>

@end

@implementation HMHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTaget:self action:@selector(pop) image:@"navigationbar_friendsearch" heightImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTaget:self action:@selector(popMore) image:@"navigationbar_pop" heightImage:@"navigationbar_pop_highlighted"];
    
    
    UIButton *homeTitleButton = [[UIButton alloc] init];
    homeTitleButton.width = 90;
    homeTitleButton.height = 30;
    [homeTitleButton setTitle:@"首页" forState:UIControlStateNormal];
    [homeTitleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [homeTitleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [homeTitleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    homeTitleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    homeTitleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 0, 0);
    [homeTitleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = homeTitleButton;
    homeTitleButton.backgroundColor = [UIColor yellowColor];

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


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
