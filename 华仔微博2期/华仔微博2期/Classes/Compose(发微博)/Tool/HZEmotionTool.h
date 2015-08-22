//
//  HZEmotionTool.h
//  华仔微博2期
//
//  Created by tarena on 15/8/19.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZEmotion;
@interface HZEmotionTool : NSObject

+(void)addEmotion:(HZEmotion *)emotion;

+(NSArray *)recentEmotions;

@end
