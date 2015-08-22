//
//  UIBarButtonItem+Extension.m
//  华仔微博2期
//
//  Created by tarena on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)


/**
 *  创建一个item
 *
 *  @param action      点击item方法
 *  @param image       图片
 *  @param HighliImage 高亮图片
 *
 *  @return 返回item
 */
+(UIBarButtonItem *)itmeWithTarget:(id)target action:(SEL)action image:(NSString *)image HighliImage:(NSString *)HighliImage
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [but addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [but setBackgroundImage: [UIImage imageNamed:image] forState:UIControlStateNormal];
    [but setBackgroundImage: [UIImage imageNamed:HighliImage] forState:UIControlStateHighlighted];
    but.size = but.currentBackgroundImage.size;
    
    return [[UIBarButtonItem alloc]initWithCustomView:but];
    
}
@end
