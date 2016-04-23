//
//  HMSeatchBarTextField.m
//  HM2
//
//  Created by 焦起龙 on 16/4/23.
//  Copyright © 2016年 JqlLove. All rights reserved.
//

#import "HMSeatchBarTextField.h"

@implementation HMSeatchBarTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        self.placeholder = @"请输入搜索条件";
        self.font = [UIFont systemFontOfSize:15];
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.contentMode = UIViewContentModeCenter;
//        searchIcon.backgroundColor = [UIColor blueColor];
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        
    }
    return self;
}
+(instancetype)searchBar
{
    
    return [[self alloc] init];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
