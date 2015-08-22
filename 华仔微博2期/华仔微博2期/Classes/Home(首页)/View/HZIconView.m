//
//  HZIconView.m
//  华仔微博2期
//
//  Created by tarena on 15/8/14.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZIconView.h"
#import "HZUser.h"
#import "UIImageView+WebCache.h"


@interface HZIconView()

@property(weak,nonatomic)UIImageView * verifiedView;


@end

@implementation HZIconView


-(UIImageView *)verifiedView
{
    if (!_verifiedView) {
        
        UIImageView *verifiedView =[[UIImageView alloc]init];
        [self addSubview:verifiedView];
        _verifiedView = verifiedView;
    }
    return _verifiedView;
}



-(void)setUser:(HZUser *)user
{
    _user = user;
    
    
    
    //下载头像
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //设置加V图片
    /*
    HZUserVerifiedTybeNone = -1, //没有任何认证
    HZUserVerifiedPersonal = 0, //个人认证
    HZUserVerifiedOrgEnterprice = 2, //企业认证
    HZUserVerifiedOrgMedia = 3, //媒体认证
    HZUserVerifiedWebsite = 5, // 网站官方认证
    HZUserVerifiedDaren = 220  //微博达人
     */
    
   
    switch (user.verified_type) {
         case HZUserVerifiedPersonal: // 个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image =[UIImage imageNamed:@"avatar_vip"];
            break;
            
        case HZUserVerifiedOrgEnterprice: //企业认证
        case HZUserVerifiedOrgMedia: //媒体认证
        case HZUserVerifiedOrgWebsite: // 网站官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
                   
        case HZUserVerifiedDaren: //微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
            
        default:
            self.verifiedView.hidden = YES;// 没有认证
            break;
            
          
    }
  

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.verifiedView.size = self.verifiedView.image.size;
    
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width *scale;
    self.verifiedView.y = self.height - self.verifiedView.height *scale;


    

}

@end
