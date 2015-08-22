//
//  HZEmotionTabBarButton.m
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionTabBarButton.h"

@implementation HZEmotionTabBarButton

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        
        //设置文字字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
    }
    return self;

}


-(void)setHighlighted:(BOOL)highlighted{
    // 按钮高亮所做的一切操作都不在了
}

@end
