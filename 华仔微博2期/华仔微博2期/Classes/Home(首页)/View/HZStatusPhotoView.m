//
//  HZStatusPhotoView.m
//  华仔微博2期
//
//  Created by tarena on 15/8/13.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZStatusPhotoView.h"
#import "HZPhoto.h"
#import "StatusPhotoView.h"
#import "StatusPhotoView.h"


#define HZStatusPhotoWH 70
#define HZStatusPhotoMargin 5
#define HZStatusPhotoMaxCol(count) ((count==4)?2:3)


@implementation HZStatusPhotoView

-(instancetype)initWithFrame:(CGRect)frame
{
    self  = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

-(void)setPhotos:(NSArray *)photos
{
    _photos = photos;

   long int photosCount = photos.count;
    //创建足够的图片控件
        while (self.subviews.count < photosCount) {
            StatusPhotoView *photoView = [[StatusPhotoView alloc]init];
           [self addSubview:photoView];
        }
    
   //遍历图片控件，设置图片
   for (int i = 0; i < self.subviews.count; i++) {
       StatusPhotoView *photoView = self.subviews[i];
       
       if (i < photosCount ) {
          photoView.photo = photos[i];
          photoView.hidden = NO;
          
      }else{//隐藏
       
          photoView.hidden = YES;
    
        }
        
        
    }
    
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置图片的尺寸和位置
    
    long int photosCount = self.photos.count;
    
    int MaxCols = HZStatusPhotoMaxCol(photosCount);
    
    for (int i = 0; i < photosCount; i++) {
        
        HZStatusPhotoView *photoView = self.subviews[i];
        
        
        int col  = i % MaxCols;
        photoView.x = col * (HZStatusPhotoWH + HZStatusPhotoMargin);
        int row = i / MaxCols;
        photoView.y = row * (HZStatusPhotoWH + HZStatusPhotoMargin);
        photoView.width = HZStatusPhotoWH;
        photoView.height = HZStatusPhotoWH;
    }
    


}

+(CGSize)sizeWithCount:(int)count
{
    //最大列数
    int MaxCols = HZStatusPhotoMaxCol(count);
    
    //列数
    int cols = (count >= MaxCols)? MaxCols :count;
    
    CGFloat photoW = cols  * HZStatusPhotoWH + (cols -1)*HZStatusPhotoMargin;
    
    //行数
    int rows = (count + MaxCols - 1) / MaxCols;
    
    CGFloat photoH = rows * HZStatusPhotoWH + (cols -1)*HZStatusPhotoMargin;
    
    return CGSizeMake(photoW, photoH);
    
}

@end
