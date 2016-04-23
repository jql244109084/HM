//
//  HMTest1ViewController.m
//  HM2
//
//  Created by 焦起龙 on 16/4/22.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMTest1ViewController.h"
#import "HMTest2ViewController.h"

@interface HMTest1ViewController ()

@end

@implementation HMTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    // Dispose of any resources that can be recreated.
    HMTest2ViewController *test2 = [[HMTest2ViewController alloc] init];
    test2.view.backgroundColor = [UIColor blueColor];
    test2.title = @"test2";
    [self.navigationController pushViewController:test2 animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
