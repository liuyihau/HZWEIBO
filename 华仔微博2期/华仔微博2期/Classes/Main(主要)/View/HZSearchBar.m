//
//  HZSearchBar.m
//  华仔微博2期
//
//  Created by tarena on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZSearchBar.h"

@implementation HZSearchBar

+(instancetype)searchBar
{
    HZSearchBar *searchBar = [[HZSearchBar alloc]init];
    
    //创建搜索框对象
    searchBar.font = [UIFont systemFontOfSize:15];
    searchBar.placeholder = @"请输入搜索内容";
    searchBar.background  =[UIImage imageNamed:@"searchbar_textfield_background"];
    
    //通过init创建初始化绝大部分控件，都是没有尺寸的
    UIImageView * Icon = [[UIImageView alloc]init];
    Icon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
    Icon.width = 30;
    Icon.height = 30;
    Icon.contentMode = UIViewContentModeCenter;
    searchBar.leftView = Icon;
    searchBar.leftViewMode = UITextFieldViewModeAlways;

    return searchBar;
}


@end
