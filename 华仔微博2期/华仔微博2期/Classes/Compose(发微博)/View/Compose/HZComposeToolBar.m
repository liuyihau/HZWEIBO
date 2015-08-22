//
//  HZComposeToolBar.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZComposeToolBar.h"

@interface  HZComposeToolBar()

@property(nonatomic,weak) UIButton * emotionButton;

@end

@implementation HZComposeToolBar



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        
        //初始化按钮
        [self setupBtnImage:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background" tag:HZComposeToolBarButtonTypeCamera];
        [self setupBtnImage:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" tag:HZComposeToolBarButtonTypePicture];
        [self setupBtnImage:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" tag:HZComposeToolBarButtonTypeMention];
        [self setupBtnImage:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" tag:HZComposeToolBarButtonTypeTrend];
        
       self.emotionButton = [self setupBtnImage:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" tag:HZComposeToolBarButtonTypeEmotion];
    }
    return self;
}

/**
 *  设置表情按钮的点击
 */
-(void)setShowKeyboardButton:(BOOL)showKeyboardButton
{
    _showKeyboardButton = showKeyboardButton;
    
    //默认的图片名
    NSString *image = @"compose_emoticonbutton_background";
    NSString *highImage = @"compose_emoticonbutton_background_highlighted";
    
    //显示的图片名
    if (showKeyboardButton) {
        image = @"compose_keyboardbutton_background";
        highImage = @"compose_keyboardbutton_background_highlighted";
    }
    
    //设置图片
    [self.emotionButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.emotionButton setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];


}


/**
 *  创建一个按钮
 *
 *  @param image     正常图片
 *  @param highImage 高亮图片
 */
-(UIButton *)setupBtnImage:(NSString *)image highImage:(NSString *)highImage tag:(HZComposeToolBarButtonType)type
{
    UIButton *btn =[[UIButton alloc]init];
    
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    btn.tag = type;
    
    [self addSubview:btn];
    return btn;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    //所有按钮的frame
    NSUInteger count = self.subviews.count;
    
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn  = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
        
    }
}


-(void)btnClick:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
//        NSUInteger index = (NSUInteger)(btn.x / btn.width);
        
        [self.delegate composeToolbar:self didClickButton:btn.tag];
        
    }


}



@end
