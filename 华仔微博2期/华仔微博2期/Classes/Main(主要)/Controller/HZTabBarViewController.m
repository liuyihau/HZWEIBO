//
//  HZTabBarViewController.m
//  华仔微博2期
//
//  Created by tarena on 15/8/5.
//  Copyright (c) 2015年 tarena. All rights reserved.
//


//// RGB颜色
//#define HZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
//
//// 随机色
//#define HZRandomColor HZColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))


#import "HZTabBarViewController.h"
#import "HZHomeViewController.h"
#import "HZMesageViewController.h"
#import "HZDiscoverViewController.h"
#import "HZProfileViewController.h"
#import "HZNavigationCotroller.h"
#import "HZTabBar.h"
#import "HZComposeViewController.h"

@interface HZTabBarViewController ()<HZTabBarDelegate>

@end

@implementation HZTabBarViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置子控制器
    
    //设置4个单个的控制器
    
    HZHomeViewController *home = [[HZHomeViewController alloc]init];
    [self addchildVc:home Title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    HZMesageViewController *messageCenter = [[HZMesageViewController alloc]init];
    [self addchildVc:messageCenter Title:@"信息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    HZDiscoverViewController *discover = [[HZDiscoverViewController alloc]init];
    [self addchildVc:discover Title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    HZProfileViewController *profile = [[HZProfileViewController alloc]init];
    [self addchildVc:profile Title: @"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
        
    
    //2.更换系统自带的tabBar
    HZTabBar *tabBar =[[HZTabBar alloc]init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
//    tabBar.delegate = self;
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"]; 相当于 tabBar.delegate = self;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HZTabBarViewController
     */
    
    /*
     1.如果tabBar设置完delegate后，在执行下面的代码（tabBar.delegate = self;）修改delegate就会报错；
     2.如果再次修改tabBar的delegate的属性，就会报下面的错误
     "Changing the delegate of a tab bar managed by a tab bar controller is not allowed"
     错误信息：不允许修改TabBar的delegate属性（这个TabBar是被TabBarViewController所管理的）
     
     
     
     */
    
    //self.tabBar = [HZTabBar alloc]init];
    //
}








/**
 *  抽取到的方法
 *
 *  @param childVc       子控制器
 *  @param title         字体
 *  @param image         图片
 *  @param selectedImage 选中图片
 *
 */

-(void)addchildVc:(UIViewController *)childVc   Title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //  设置子控制器
    
//    childVc.tabBarItem.title = title;
//    childVc.navigationItem.title = title;
    
    childVc.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HZColor(123, 123, 123);
    
    NSMutableDictionary *selectedTetextAttrs = [NSMutableDictionary dictionary];
    selectedTetextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectedTetextAttrs forState:UIControlStateSelected];
//    childVc.view.backgroundColor = HZRandomColor;
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
   HZNavigationCotroller *nav = [[HZNavigationCotroller alloc]initWithRootViewController:childVc];
    
    
    //添加子控制器
    [self addChildViewController:nav];
    
    
}

#pragma mark -- HZTabBarDelegate 的代理方法

-(void)tabBarDidCilckPlusButton:(HZTabBar *)tabBar
{
    HZComposeViewController *vc = [[HZComposeViewController alloc]init];
    HZNavigationCotroller *nvc = [[HZNavigationCotroller alloc]initWithRootViewController:vc];
    
    [self presentViewController:nvc animated:YES completion:nil];


}




@end
