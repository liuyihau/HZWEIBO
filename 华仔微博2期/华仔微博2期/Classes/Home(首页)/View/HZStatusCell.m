//
//  HZStatusCell.m
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZStatusCell.h"
#import "HZStatus.h"
#import "HZStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "HZUser.h"
#import "HZPhoto.h"
#import "HZStatusToolbar.h"
#import "HZStatusPhotoView.h"
#import "HZIconView.h"

@interface HZStatusCell()

/*原创微博*/
//**微博整体*/
@property(weak,nonatomic)UIView *originalView;
//**头像*/
@property(weak,nonatomic)HZIconView *iconView;
//**会员图标*/
@property(weak,nonatomic)UIImageView *vipView;
//**配图*/
@property(weak,nonatomic)HZStatusPhotoView * photosView;
//**昵称*/
@property(weak,nonatomic)UILabel *nameLabel;
//**时间*/
@property(weak,nonatomic)UILabel *timeLabel;
//**来源*/
@property(weak,nonatomic)UILabel *sourceLabel;
//**正文*/
@property(weak,nonatomic)UILabel *contentLabel;


/*转发微博整体*/
/**转发微博整体*/
@property(weak,nonatomic)UIView *retweetView;
/**昵称 + 正文*/
@property(weak,nonatomic)UILabel *retweetContentLabel;
/**转发配图*/
@property(weak,nonatomic)HZStatusPhotoView *retweetPhotosView;

/**转发微博整体*/
@property(weak,nonatomic)HZStatusToolbar *toolBarView;

@end

@implementation HZStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
        static NSString *ID = @"status";
        HZStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) {
            cell = [[HZStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
            
        }
    cell.backgroundColor = HZColor(211, 211, 211);
    //设置不可选状态
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

/**
 *  cell的初始化方法，一个cell只会调用一次
 *  一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //初始化原创微博
        [self setupOriginal];
        
        //初始化转发微博
        [self setupRetweet];
        
        //初始化工具条
        [self setupToolBar];

        
    }
    return self;
}
/**
 *  初始化工具条
 */
-(void)setupToolBar
{
    HZStatusToolbar *toolBarView  = [HZStatusToolbar HZToolbar];
    [self.contentView addSubview:toolBarView];
    self.toolBarView = toolBarView;

}


/**
 *  初始化转发微博
 */
-(void)setupRetweet
{
    //1.转发微博整体
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = HZColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    //2.转发 昵称 + 正文
    UILabel *retweetContLabel=[[UILabel alloc]init];
    retweetContLabel.numberOfLines = 0;
    retweetContLabel.font = HZStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContLabel];
    self.retweetContentLabel = retweetContLabel;

    
    //3.转发微博配图
    HZStatusPhotoView *retweetPhotosView = [[HZStatusPhotoView alloc]init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;

}

/**
 *  初始化原创微博
 */
-(void)setupOriginal
{
    //1.原创微博整体
    UIView *originalView = [[UIView alloc]init];
    originalView.backgroundColor  = [UIColor whiteColor];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    //**头像*/
    HZIconView *iconView = [[HZIconView alloc]init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    //**会员图标*/
    UIImageView *vipView =[[UIImageView alloc]init];
    [originalView addSubview:vipView];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    
    //**配图*/
    HZStatusPhotoView *photosView=[[HZStatusPhotoView alloc]init];
    [originalView addSubview:photosView];
    self.photosView = photosView;
    
    //**昵称*/
    UILabel *nameLabel=[[UILabel alloc]init];
    nameLabel.font = HZStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    //**时间*/
    UILabel *timeLabel=[[UILabel alloc]init];
    timeLabel.font = HZStatusCellTimeFont;
    timeLabel.textColor = [UIColor orangeColor];
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    //**来源*/
    UILabel *sourceLabel=[[UILabel alloc]init];
    sourceLabel.font = HZStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    //**正文*/
    UILabel *contentLabel=[[UILabel alloc]init];
    contentLabel.font = HZStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;

}


- (void)setStatusFrame:(HZStatusFrame *)statusFrame
{

    _statusFrame = statusFrame;
    
    HZStatus *status = statusFrame.status;
    
    HZUser *user = status.user;
    
    
    //原创微博整体
   
    self.originalView.frame =  statusFrame.originalViewF;
    
    //**头像*/
   
    self.iconView.frame = statusFrame.iconViewF;
    
    self.iconView.user = user;
    
    
    //**会员图标*/
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    //**配图*/
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos =status.pic_urls;
        self.photosView.hidden = NO;
    }else{
        _photosView.hidden = YES;
    }
    
    //**昵称*/
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    
    /** 时间 */
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + HZStatusCellBorderW;
    CGSize timeSize = [time sizeWithfont:HZStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + HZStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithfont:HZStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;

    
    //**正文*/
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    

    
    /*转发微博*/
    if (status.retweeted_status) {
        HZStatus *retweeted_status = status.retweeted_status;
        HZUser *retweeted_status_user =  retweeted_status.user;
        
        self.retweetView.hidden = NO;
        
    /**转发微博整体*/
    self.retweetView.frame = statusFrame.retweetViewF;
    
    /**昵称 + 正文*/
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
    self.retweetContentLabel.text = retweetContent;
    self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
    
        /**被转发配图*/
        if (retweeted_status.pic_urls.count) {//有配图
            
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            
            self.retweetView.hidden = NO;//不隐藏
            
        }else{//无配图
            
            self.retweetView.hidden = YES;//隐藏
        }

    }else{
            _retweetView.hidden = YES;
        
    }
    
    
    /**工具条*/
    self.toolBarView.frame = statusFrame.toolBarF;
    self.toolBarView.status = status;
    
    
  }



@end


















