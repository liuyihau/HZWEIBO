//
//  HZTextView.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZTextView : UITextView
/**
 *  占位字符
 */
@property(nonatomic,copy) NSString * placeholder;
/**
 *  占位字符的颜色
 */
@property(strong,nonatomic) UIColor * placeholderColor;
@end
