//
//  HZUser.m
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZUser.h"

@implementation HZUser

-(void)setMbtype:(int)mbtype
{
    _mbrank = mbtype;
    self.vip = mbtype > 2;

}

@end
