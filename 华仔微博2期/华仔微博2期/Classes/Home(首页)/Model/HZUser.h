//
//  HZUser.h
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    HZUserVerifiedTypeNone = -1, // 没有任何认证
    
    HZUserVerifiedPersonal = 0,  // 个人认证
    
    HZUserVerifiedOrgEnterprice = 2, // 企业官方：CSDN、EOE、搜狐新闻客户端
    HZUserVerifiedOrgMedia = 3, // 媒体官方：程序员杂志、苹果汇
    HZUserVerifiedOrgWebsite = 5, // 网站官方：猫扑
    
    HZUserVerifiedDaren = 220 // 微博达人
} HZUserVerifiedTybe;

@interface HZUser : NSObject
/**idstr	string	字符串型的用户UID*/
@property(copy,nonatomic)NSString *idstr;
/**name	string	友好显示名称*/
@property(copy,nonatomic)NSString *name;
/**profile_image_url	string	用户头像地址*/
@property(copy,nonatomic)NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;

@property (nonatomic, assign, getter = isVip) BOOL vip;
/**认证类型*/
@property(assign,nonatomic) HZUserVerifiedTybe verified_type;


@end
