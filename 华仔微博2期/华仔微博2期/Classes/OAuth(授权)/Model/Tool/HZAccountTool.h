//
//  HZAccountTool.h
//  华仔微博2期
//
//  Created by tarena on 15/8/8.
//  Copyright (c) 2015年 tarena. All rights reserved.
//  处理账号相关的所有操作：存储账号 读取账号 验证账号

#import <Foundation/Foundation.h>
#import "HZAccount.h"

@interface HZAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+(void)saveAccout:(HZAccount *)account;

/**
 *  返回账号信息
 *
 *  @return 账号模型
 */
+(HZAccount *)account;

@end
