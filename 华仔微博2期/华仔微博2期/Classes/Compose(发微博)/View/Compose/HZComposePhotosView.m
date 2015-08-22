//
//  HZComposePhotosView.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZComposePhotosView.h"
@interface HZComposePhotosView()
@end

@implementation HZComposePhotosView



-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _photos = [NSMutableArray array];
    }
    return self;

}




-(void)addPhoto:(UIImage *)photo
{
    UIImageView *photoView = [[UIImageView alloc]init];
    photoView.image = photo;
    [self addSubview:photoView];
    //存储图片
    [self.photos addObject:photo];
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    
    NSUInteger count = self.subviews.count;
    
    int MaxCols = 4;
    CGFloat imageWH = 70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i < count; i++) {
        
        UIImageView *photoView = self.subviews[i];
        
        int col  = i % MaxCols;
        photoView.x = col * (imageWH + imageMargin);
        
        int row = i / MaxCols;
        photoView.y = row * (imageWH + imageMargin);
        photoView.width = imageWH;
        photoView.height = imageWH;

        }
}
    
    
@end
