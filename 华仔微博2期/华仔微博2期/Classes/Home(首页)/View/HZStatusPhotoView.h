//
//  HZStatusPhotoView.h
//  华仔微博2期
//
//  Created by tarena on 15/8/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
// cell上面的配图相册（里面会显示1~9张相片,里面都是StatusPhoto）

#import <UIKit/UIKit.h>

@interface HZStatusPhotoView : UIView
@property(strong,nonatomic)NSArray *photos;
//根据图片个数计算图片尺寸
+(CGSize)sizeWithCount:(int)count;


@end
