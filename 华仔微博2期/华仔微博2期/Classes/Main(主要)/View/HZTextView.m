//
//  HZTextView.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZTextView.h"

@implementation HZTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //不要设置自己的代理
        //self.delegate = self;
        
        //通知
        //当UITextView的文字发生改变时，UITextView自己会发出一个UITextViewDidChangeNotification通知
        [HZNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
                    
    }
    return self;

}


-(void)dealloc
{
    [HZNotificationCenter removeObserver:self];

}
/**
 *  监听文字改变
 */
-(void)textDidChange
{
//重绘 重新调用
    [self setNeedsDisplay];

}

//set重写
-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];

}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];


}
-(void)setText:(NSString *)text
{
    [super setText:text];
    [self setNeedsDisplay];
    
}

-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];


}

-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    [self setNeedsDisplay];

}




- (void)drawRect:(CGRect)rect {
    //    [HWRandomColor set];
    //    UIRectFill(CGRectMake(20, 20, 30, 30));
    // 如果有输入文字，就直接返回，不画占位文字
    if (self.hasText) return;
    
    //文字属性
    NSMutableDictionary * attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    //画文字
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
    
}


@end
