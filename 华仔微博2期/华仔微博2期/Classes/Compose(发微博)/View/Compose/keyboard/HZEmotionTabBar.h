//
//  HZEmotionTabBar.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//  表情键盘底下选项卡

#import <UIKit/UIKit.h>
typedef enum{
    HZEmotionTabBarButtonTypeRecent, // 最近
    HZEmotionTabBarButtonTypeDefault, // 默认
    HZEmotionTabBarButtonTypeEmoji, // emoji
    HZEmotionTabBarButtonTypeLxh    // 浪

}HZEmotionTabBarButtonType;

@class HZEmotionTabBar;

@protocol  HZEmotionTabBarDelegate <NSObject>
@optional

-(void)emtionTabBar:(HZEmotionTabBar *)tabBar didSelectButton:(HZEmotionTabBarButtonType)buttonType;

@end

@interface HZEmotionTabBar : UIView
@property(weak,nonatomic)id<HZEmotionTabBarDelegate> delegate;

@end
