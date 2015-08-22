//
//  HZTitleButton.m
//  华仔微博2期
//
//  Created by tarena on 15/8/9.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZTitleButton.h"

#define HZMargin 10

@implementation HZTitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.imageView.backgroundColor = [UIColor clearColor];
        
    }
    return self;
    
}

// 目的:想再系统计算完按钮的尺寸后，在修改一下尺寸
// self.frame = CGRect

/**
 *  重写setFrame方法的目的：拦截设置按钮尺寸的过程
 *  如果想再系统设置完控件的尺寸后，在做修改，而且要保证修改成功，一般都是在setFrame中设置
 *
 */
-(void)setFrame:(CGRect)frame
{
    frame.size.width += HZMargin;
    [super setFrame:frame];
  
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    // 如果仅仅是调整按钮内部titleLabel和imageView的位置，那么在layoutSubviews中单独设置位置即可
    
    // 1.计算titleLabel的frame
    self.titleLabel.x = self.imageView.x;
    
    // 2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + HZMargin;
    
    
}
-(void)setImage:(UIImage *)image forState:(UIControlState)state
{
    
    [super setImage:image forState:state];
    [self sizeToFit];

}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];

}





























@end
