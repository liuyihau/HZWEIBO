//
//  HZEmotion.h
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZEmotion : NSObject
/**
 *  表情的文字描述
 */
@property(copy,nonatomic)NSString *chs;
/**
 *  表情的png图片名
 */
@property(copy,nonatomic)NSString *png;
/**
 *  emoji表情的16进制编码
 */
@property(copy,nonatomic)NSString *code;


@end
