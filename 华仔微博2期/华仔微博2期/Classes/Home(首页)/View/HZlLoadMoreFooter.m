//
//  HZlLoadMoreFooter.m
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZlLoadMoreFooter.h"

@implementation HZlLoadMoreFooter

+(instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HZlLoadMoreFooter" owner:nil options:nil] lastObject];



}
@end
