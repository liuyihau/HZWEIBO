//
//  HZEmotionKeyboard.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionKeyboard.h"
#import "HZEmotionListView.h"
#import "HZEmotionTabBar.h"
#import "HZEmotion.h"
#import "MJExtension.h"
#import "HZEmotionTool.h"

@interface HZEmotionKeyboard()<HZEmotionTabBarDelegate>
/**
 *  保存正在显示的listView
 */
@property(weak,nonatomic)HZEmotionListView * showingListView;
/**
 *  表情内容
 */
@property(strong,nonatomic)HZEmotionListView *recentListView;
@property(strong,nonatomic)HZEmotionListView *defaultListView;
@property(strong,nonatomic)HZEmotionListView *emojiListView;
@property(strong,nonatomic)HZEmotionListView *lxhListView;

/**
 *  tabBar
 */
@property(weak,nonatomic)HZEmotionTabBar *tabBar;

@end

@implementation HZEmotionKeyboard

#pragma mark -- 懒加载

- (HZEmotionListView *)recentListView
{
    if (!_recentListView) {
        _recentListView = [[HZEmotionListView alloc] init];
        
        //加载沙盒中的数据
        self.recentListView.emotions =  [HZEmotionTool recentEmotions];
        
      
    }
    return _recentListView;
}

- (HZEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        _defaultListView = [[HZEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        //模型数组转换
        self.defaultListView.emotions = [HZEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
      
    }
    return _defaultListView;
}

- (HZEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        _emojiListView = [[HZEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        //模型数组转换
        self.emojiListView.emotions = [HZEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];

      
    }
    return _emojiListView;
}

- (HZEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        _lxhListView = [[HZEmotionListView alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        //模型数组转换
        self.lxhListView.emotions = [HZEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
        
    }
    return _lxhListView;
}
#pragma mark -- 初始化

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        //tabBar
        HZEmotionTabBar *tabBar = [[HZEmotionTabBar alloc]init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        
        //监听表情选中的通知
        
        [HZNotificationCenter addObserver:self selector:@selector(emotionDidSelect) name:HZEmotionDidSelectNotification object:nil];
    }
    return self;

}

-(void)emotionDidSelect
{
    self.recentListView.emotions = [HZEmotionTool recentEmotions];
}


-(void)dealloc
{
    [HZNotificationCenter removeObserver:self];

}



-(void)layoutSubviews
{
    [super layoutSubviews];
    //1.tabBar
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    //2.listView
    self.showingListView.width =self.width;
    self.showingListView.height = self.tabBar.y;
    self.showingListView.x = self.showingListView.y =0;
    
    

}


#pragma mark - HWEmotionTabBarDelegate

-(void)emtionTabBar:(HZEmotionTabBar *)tabBar didSelectButton:(HZEmotionTabBarButtonType)buttonType
{
    //移除ListView之前显示的控件
    [self.showingListView removeFromSuperview];
    
    switch (buttonType) {
        case HZEmotionTabBarButtonTypeRecent:{//最近
            [self addSubview:self.recentListView];
            break;
        }
        case HZEmotionTabBarButtonTypeDefault:{//默认
            [self addSubview:self.defaultListView];
            break;
        }
        case HZEmotionTabBarButtonTypeEmoji:{//Emoji
            [self addSubview:self.emojiListView];
            break;
        }
        case HZEmotionTabBarButtonTypeLxh:{//Lxh
            [self addSubview:self.lxhListView];
            break;
        }
    }
    
    // 设置正在显示的listView
    self.showingListView = [self.subviews lastObject];
    
    [self setNeedsLayout];


}



@end
