//
//  HZEmotionPageView.h
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//  用来表示一页的表情（里面显示1~20个表情）

#import <UIKit/UIKit.h>
//一页中最多3行
#define HZEmotionMaxRows 3
//一页中最多7列
#define HZEmotionMaxCols 7
//每一页的表情个数
#define HZEmotionPageSize ((HZEmotionMaxRows * HZEmotionMaxCols) - 1)



@interface HZEmotionPageView : UIView
/**
 *  这一页显示的表情（里面都是HZEmotion模型）
 */
@property(strong,nonatomic)NSArray * emotions;


@end
