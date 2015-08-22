//
//  HZTabBar.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZTabBar.h"

@interface HZTabBar()

@property(weak,nonatomic) UIButton * plusBtn;

@end

@implementation HZTabBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    //添加一个按钮到tabbar中
        //2.添加一个按钮到tabbar中
        UIButton *plusBtn = [[UIButton alloc]init];
       
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateNormal];
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        //点击事件
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:plusBtn];
        
        self.plusBtn = plusBtn;
        
    }
    return self;
}
/**
 *  加号按钮点击
 */
- (void)plusClick
{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidCilckPlusButton:)]) {
        [self.delegate tabBarDidCilckPlusButton:self];
    }
    
}



- (void)layoutSubviews
{
    [super layoutSubviews];
  
    //1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    //2.设置其他tabBarButton的位置和尺寸
    CGFloat tabBarButtonW = self.width / 5;
    CGFloat tabBarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
            if ([child isKindOfClass:class]) {
                //设置宽度
                child.width = tabBarButtonW;
               //设置x
                child.x = tabBarButtonIndex * tabBarButtonW;

                //增加索引
                tabBarButtonIndex++;
                //再次增加索引 让发现按钮退至第三个位置
                if (tabBarButtonIndex == 2) {
                    tabBarButtonIndex++;
                }
            }
        }

    }
    
    
//        long count = self.subviews.count;
//        for (int i  = 0 ; i < count ; i++) {
//            UIView *child = self.subviews[i];
//            Class class = NSClassFromString(@"UITabBarButton");
//            if ([child isKindOfClass:class]) {
//                //设置宽度
//                child.width = tabBarButtonW;
//               //设置x
//                child.x = tabBarButtonIndex * tabBarButtonW;
//                
//                //增加索引
//                tabBarButtonIndex++;
//                //再次增加索引 让发现按钮退至第三个位置
//                if (tabBarButtonIndex == 2) {
//                    tabBarButtonIndex++;
//                }
//            }
//        }
    
    
@end

