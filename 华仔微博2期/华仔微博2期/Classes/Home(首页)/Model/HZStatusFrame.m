//
//  HZStatusFrame.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZStatusFrame.h"
#import "HZStatus.h"
#import "HZUser.h"
#import "HZPhoto.h"
#import "HZStatusPhotoView.h"


@implementation HZStatusFrame

-(void)setStatus:(HZStatus *)status
{
    _status =status;
    
    HZUser *user =status.user;
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //**头像*/
    CGFloat iconViewHW = 40;
    CGFloat iconViewX = HZStatusCellBorderW;
    CGFloat iconViewY = HZStatusCellBorderW;
    self.iconViewF = CGRectMake(iconViewX, iconViewY, iconViewHW, iconViewHW);
    
    //**昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + HZStatusCellBorderW;
    CGFloat nameY = iconViewY;
    CGSize nameSize = [user.name sizeWithfont:HZStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    //**会员图标*/
    if (user.isVip) {
        CGFloat vipX= CGRectGetMaxX(self.nameLabelF) + HZStatusCellBorderW;
        CGFloat vipY= nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW,vipH);
        
    }
    
    //**时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + HZStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithfont:HZStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX,timeY},timeSize};
    
    //**来源*/
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + HZStatusCellBorderW;
    CGFloat sourceY = CGRectGetMaxY(self.nameLabelF) + HZStatusCellBorderW;
    CGSize sourceSize = [status.source sizeWithfont:HZStatusCellContentFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};
    
    
    //**正文*/
    CGFloat contentX = iconViewX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF))  + HZStatusCellBorderW;
    CGFloat maxW =  cellW - 2*contentX;
    CGSize contentSize = [status.text sizeWithfont:HZStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};


    
    //**配图*/
    CGFloat originalViewH = 0;
   if (status.pic_urls.count) {
      
       CGFloat photosX = contentX;
       CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + HZStatusCellMARGIN;
       
       CGSize photosSize = [HZStatusPhotoView sizeWithCount:(int)status.pic_urls.count];
        self.photosViewF = (CGRect){{photosX,photosY},photosSize};
       
       
         originalViewH = CGRectGetMaxY(self.photosViewF) + HZStatusCellBorderW;
       
    }else{//没配图
    
        originalViewH = CGRectGetMaxY(self.contentLabelF) + HZStatusCellBorderW;

   }
    
    
    //**原创微博整体*/
    
    CGFloat originalViewX = 0;
    CGFloat originalViewY = HZStatusCellMARGIN;
    CGFloat originalViewW = cellW;
    self.originalViewF = CGRectMake(originalViewX, originalViewY, originalViewW, originalViewH);
 
    
    CGFloat toolBarY = 0;
    
   
    
    /* 被转发微博 */
    if (status.retweeted_status) {
        
        HZStatus *retweeted_status = status.retweeted_status;
        HZUser *retweeted_status_user = retweeted_status.user;
        
        /** 被转发微博正文 */
        CGFloat retweetContentX = HZStatusCellBorderW;
        CGFloat retweetContentY = HZStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithfont:HZStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
     
        /** 被转发微博配图 */
        CGFloat retweetH = 0;
       if (retweeted_status.pic_urls.count) { // 转发微博有配图
         
          CGFloat retweetPhotoX = retweetContentX;
           CGFloat retweetPhotoY = CGRectGetMaxY(self.retweetContentLabelF) + HZStatusCellBorderW;
           CGSize retweetphotosSize = [HZStatusPhotoView sizeWithCount:(int)retweeted_status.pic_urls.count];
           self.retweetPhotosViewF = (CGRect){{retweetPhotoX,retweetPhotoY},retweetphotosSize};
           
           retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + HZStatusCellBorderW;
       } else { // 转发微博没有配图
        
            retweetH = CGRectGetMaxY(self.contentLabelF) + HZStatusCellBorderW;
       }
        
        /** 被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.originalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolBarY = CGRectGetMaxY(self.retweetViewF);
    }else {
        
        toolBarY = CGRectGetMaxY(self.originalViewF);
    }

    /**工具条*/
    CGFloat toolBarX = 0;
    CGFloat toolBarW = cellW;
    CGFloat toolBarH = 30;
    self.toolBarF = CGRectMake(toolBarX, toolBarY, toolBarW, toolBarH);
    
    
    self.cellHeight = CGRectGetMaxY(self.toolBarF);
}

@end
