//
//  HZEmotionPopView.m
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionPopView.h"
#import "HZEmotionButton.h"

@interface HZEmotionPopView()

@property (weak, nonatomic) IBOutlet HZEmotionButton *emotionButton;

@end
@implementation HZEmotionPopView


-(void)showFrom:(HZEmotionButton *)button
{
    if (button == nil) return;
    
    // 给popView传递数据
    self.emotionButton.emotion = button.emotion;

    // 取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];

    // 计算出被点击的按钮在window中的frame
    CGRect btnFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) - self.height; // 100
    self.centerX = CGRectGetMidX(btnFrame);

}



+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HZEmotionPopView" owner:nil options:nil] lastObject];
    
}



@end
