//
//  HZEmotionTabBar.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionTabBar.h"
#import "HZEmotionTabBarButton.h"
@interface HZEmotionTabBar()
@property(weak,nonatomic)HZEmotionTabBarButton *selectedBtn;


@end

@implementation HZEmotionTabBar

-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:HZEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:HZEmotionTabBarButtonTypeDefault];
        //        [self btnClick:[self setupBtn:@"默认" buttonType:HWEmotionTabBarButtonTypeDefault]];
        [self setupBtn:@"Emoji" buttonType:HZEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:HZEmotionTabBarButtonTypeLxh];
      
        
    }
    return self;

}

/**
 *  创建一个按钮
 *
 *  @param title      标题
 *  @param buttonType 类型
 *
 *  @return 按钮
 */
-(HZEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(HZEmotionTabBarButtonType)buttonType
{
    //创建按钮
    HZEmotionTabBarButton *btn = [[HZEmotionTabBarButton alloc]init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];

   
    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }else if(self.subviews.count == 4){
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    

    return btn;
}



/**
 *  设置位置和尺寸
 */
-(void)layoutSubviews
{

    [super layoutSubviews];
    //设置按钮的frame
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat  btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        HZEmotionTabBarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.width = btnW;
        btn.x = i *btnW;
        btn.height = btnH;
    }

}

-(void)setDelegate:(id<HZEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    
    //选中‘默认按钮’
    [self btnClick:(HZEmotionTabBarButton *)[self viewWithTag:HZEmotionTabBarButtonTypeDefault]];



}


/**
 *  按钮点击
 */
-(void)btnClick:(HZEmotionTabBarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emtionTabBar:didSelectButton:)]) {
        [self.delegate emtionTabBar:self didSelectButton:btn.tag];
    }


}


@end
