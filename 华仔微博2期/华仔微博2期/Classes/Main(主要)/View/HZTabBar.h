//
//  HZTabBar.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZTabBar;

#warning 因为HZTabBar继承自UITabBar,所以成为HZTabBar的代理，也必须实现UITabBar的代理协议

@protocol HZTabBarDelegate <UITabBarDelegate>

@optional

-(void)tabBarDidCilckPlusButton:(HZTabBar *)tabBar;

@end

@interface HZTabBar : UITabBar

@property(weak,nonatomic) id<HZTabBarDelegate> delegate;



@end
