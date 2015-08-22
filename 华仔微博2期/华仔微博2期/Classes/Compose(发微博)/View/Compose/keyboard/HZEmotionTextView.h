//
//  HZEmotionTextView.h
//  华仔微博2期
//
//  Created by tarena on 15/8/19.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZTextView.h"
@class HZEmotion;


@interface HZEmotionTextView : HZTextView

-(void)insertEmotion:(HZEmotion *)emotion;


-(NSString *)fullText;
@end
