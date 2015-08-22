//
//  HZStatus.h
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HZUser;
@interface HZStatus : NSObject

/**idstr	string	字符串型的微博ID*/
@property(copy,nonatomic)NSString *idstr;

/**text	string	微博信息内容*/
@property(copy,nonatomic)NSString *text;

/**user	object	微博作者的用户信息字段 详细*/
@property(strong,nonatomic)HZUser * user;

/**	string	微博创建时间*/
@property (copy,nonatomic) NSString * created_at;

/**	string	微博来源*/
@property (copy,nonatomic) NSString * source;

/**微博配图ID。多图时返回多图ID，用来拼接图片url。用返回字段thumbnail_pic的地址配上该返回字段的图片ID，即可得到多个图片url*/
@property(strong,nonatomic)NSArray * pic_urls;


/**被转发的原微博信息字段，当该微博为转发微博时返回*/

@property(strong,nonatomic)HZStatus * retweeted_status;


/**reposts_count	int	转发数*/
@property(assign,nonatomic) int  reposts_count;
/**comments_count	int	评论数*/
@property(assign,nonatomic) int  comments_count;
/**attitudes_count	int	表态数*/
@property(assign,nonatomic) int  attitudes_count;









@end
