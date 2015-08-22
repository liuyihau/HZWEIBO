//
//  HZDorpdownMenu.h
//  华仔微博2期
//
//  Created by tarena on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZDorpdownMenu;

@protocol HZDorpdownMenuDelegate <NSObject>
@optional
- (void)dorpdownMenuDidDismiss:(HZDorpdownMenu *)Menu;
- (void)dorpdownMenuDidShow:(HZDorpdownMenu *)Menu;

@end

@interface HZDorpdownMenu : UIView
@property(weak,nonatomic) id<HZDorpdownMenuDelegate> delegate;


+(instancetype)Menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;
/**
 *  内容
 */
@property(strong,nonatomic)UIView *content;

/**
 *  内容控制器
 */
@property(nonatomic,strong) UIViewController *contentViewController;

@end
