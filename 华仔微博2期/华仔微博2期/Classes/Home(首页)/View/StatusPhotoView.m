//
//  StatusPhotoView.m
//  华仔微博2期
//
//  Created by tarena on 15/8/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "StatusPhotoView.h"
#import "HZPhoto.h"
#import "UIImageView+WebCache.h"

@interface StatusPhotoView()
@property(weak,nonatomic)UIImageView * gifView;

@end

@implementation StatusPhotoView


- (UIImageView *)gifView
{
    if (!_gifView) {
         UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
         UIImageView *gifView = [[UIImageView alloc]initWithImage:image];
        
        [self addSubview:gifView];
         self.gifView = gifView;
    }
    return _gifView;
}


- (id)initWithFrame:(CGRect)frame
{
    
//UIViewContentModeScaleToFill,      拉伸至填充整个imageView（图片可能会变形）
//UIViewContentModeScaleAspectFit,   保持宽高比拉伸，完全显示在imageView内为止（图片不会变形）fit 自适应
//UIViewContentModeScaleAspectFill,  保持宽高比拉伸，达到其中一边与imageView的一边相等显示，会超出范围（图片不会变形），应该配合clipsToBounds使用
    
    
    //带有scale会拉伸
    //带有aspect会保持宽高比
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        }
    return self;
}


-(void)setPhoto:(HZPhoto *)photo
{
    _photo = photo;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];

    //显示，隐藏git控件
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];

 
    }


-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;

}

@end
