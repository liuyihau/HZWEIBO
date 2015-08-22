//
//  HZNavigationCotroller.m
//  华仔微博2期
//
//  Created by tarena on 15/8/5.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZNavigationCotroller.h"

@implementation HZNavigationCotroller


+(void)initialize{//在第一次使用时调用
    
//    [UINavigationBar appearance]; //设置导航栏的文字大小和颜色等
    
   UIBarButtonItem *item =  [UIBarButtonItem appearance]; //设置导航栏所有的item的主题样式
    
    
    //设置普通样式
    NSMutableDictionary *textAttrs =[NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] =[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    
//    //设置不可选样式
    NSMutableDictionary *disableTextAttrs =[NSMutableDictionary dictionary];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    disableTextAttrs[NSFontAttributeName] =[UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];

}


//重写push方法
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
   
    if (self.viewControllers.count > 0)
    {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem itmeWithTarget:self action:@selector(back) image:@"navigationbar_back" HighliImage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem itmeWithTarget:self action:@selector(more) image:@"navigationbar_more" HighliImage:@"navigationbar_more_highlighted"];
    }
     [super pushViewController:viewController animated:YES];

}


-(void)more

// 因为self本来就是一个导航控制器，self.navigationController这里是nil的
{
    [self popToRootViewControllerAnimated:YES];
    
}
-(void)back
{
    [self popViewControllerAnimated:YES];
}





@end
