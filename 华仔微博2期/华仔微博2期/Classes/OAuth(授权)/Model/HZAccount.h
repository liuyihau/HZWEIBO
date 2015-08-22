//
//  HZAccount.h
//  华仔微博2期
//
//  Created by tarena on 15/8/8.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZAccount : NSObject<NSCoding>
/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**
 *  access_token的创建时间
 */
@property(strong,nonatomic)NSDate *created_time;

/** 账号的名字*/
@property(copy,nonatomic)NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
