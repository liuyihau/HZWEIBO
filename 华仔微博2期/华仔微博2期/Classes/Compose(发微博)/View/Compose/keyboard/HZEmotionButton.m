//
//  HZEmotionButton.m
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionButton.h"
#import "HZEmotion.h"
#import "NSString+Emoji.h"

@implementation HZEmotionButton

/**
 *  当控件不是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

/**
 *  当控件是从xib、storyboard中创建时，就会调用这个方法
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super initWithCoder:decoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    //按钮高亮的时候，不要去调整图片(不要调整图片会灰色)
    self.adjustsImageWhenHighlighted = NO;
//    self.adjustsImageWhenDisabled
}

/**
 *  这个方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib
{
    
}

- (void)setEmotion:(HZEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) { // 有图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) { // 是emoji表情
        // 设置emoji
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}
//
//-(void)setHighlighted:(BOOL)highlighted
//{
//
//}

@end
