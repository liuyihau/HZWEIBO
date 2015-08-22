//
//  HZEmotionPopView.h
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZEmotion,HZEmotionButton;

@interface HZEmotionPopView : UIView

+ (instancetype)popView;

-(void)showFrom:(HZEmotionButton *)button;


@end
