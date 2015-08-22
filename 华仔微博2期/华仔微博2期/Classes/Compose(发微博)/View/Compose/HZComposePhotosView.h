//
//  HZComposePhotosView.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HZComposePhotosView : UIView
- (void)addPhoto:(UIImage *)photo;

//@property (nonatomic, strong, readonly) NSArray *photos;
//- (NSArray *)photos;

@property(strong,nonatomic,readonly) NSMutableArray  * photos;


// 默认会自动生成setter和getter的声明和实现、_开头的成员变量
// 如果手动实现了setter和getter，那么就不会再生成settter、getter的实现、_开头的成员变量

//@property (nonatomic, strong, readonly) NSMutableArray *addedPhotos;
// 默认会自动生成getter的声明和实现、_开头的成员变量
// 如果手动实现了getter，那么就不会再生成getter的实现、_开头的成员变量

@end
