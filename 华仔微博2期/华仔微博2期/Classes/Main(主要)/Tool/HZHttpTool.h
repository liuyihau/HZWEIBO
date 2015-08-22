//
//  HZHttpTool.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/20.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZHttpTool : NSObject
+ (void)Get:(NSString *)url params:(NSDictionary *)params success:(void (^) (id json))success failure:(void (^) (NSError *error))failure;

+ (void)Post:(NSString *)url params:(NSDictionary *)params success:(void (^) (id json))success failure:(void (^) (NSError *error))failure;
@end
