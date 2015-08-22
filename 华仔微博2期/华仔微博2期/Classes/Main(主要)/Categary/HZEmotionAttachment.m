//
//  HZEmotionAttachment.m
//  华仔微博2期
//
//  Created by tarena on 15/8/19.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionAttachment.h"
#import "HZEmotion.h"
@implementation HZEmotionAttachment

-(void)setEmotion:(HZEmotion *)emotion
{
    _emotion = emotion;

    self.image = [UIImage imageNamed:emotion.png];
   
}

@end
