//
//  HZAccountTool.m
//  华仔微博2期
//
//  Created by tarena on 15/8/8.
//  Copyright (c) 2015年 tarena. All rights reserved.
//



//沙盒路径
#define HZAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]


#import "HZAccountTool.h"


@implementation HZAccountTool

/**
 *  存储账号信息
 *
 *  @param account 账号模型
 */
+(void)saveAccout:(HZAccount *)account

{    
    // 自定义对象的存储必须用NSKeyedArchiver，不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HZAccountPath];
    
}

/**
 *  返回账号信息
 *
 *  @return 账号模型(如果过期，则返回nil)
 */
+(HZAccount *)account
{
    //加载模型
    HZAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HZAccountPath];
    
    
    /**
     *  验证账号是否过期
     */
    
    //过期的秒数
   long long expires_in = [account.expires_in longLongValue];
    
    
    //获得过期的时间
     NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    //当前时间
    NSDate *now = [NSDate date];
    
    //如果now >= expiresTime,过期

    /*
     *  NSOrderedAscending  升序 左边 < 右边
     *NSOrderedSame, 一样
     *NSOrderedDescending  降序  左边 > 右边
      */
    
    NSComparisonResult result = [expiresTime compare:now];
    
    if (result != NSOrderedDescending ) {//过期
        return  nil;
    }
    
  

    return account;
    
    //验证生命周期
    
    
    
}



@end
