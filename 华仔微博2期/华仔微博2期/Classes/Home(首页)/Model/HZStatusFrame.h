//
//  HZStatusFrame.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//  一个HZStatusFrame模型里面包含的信息
//  1.存放着一个cell内部所有子控件的frame数据
//  2.存放一个cell的高度
//  3.存放着一个数据模型HZStatus

#import <Foundation/Foundation.h>

// 昵称字体
#define HZStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define HZStatusCellTimeFont [UIFont systemFontOfSize:12]
// 来源字体
#define HZStatusCellSourceFont HZStatusCellTimeFont
// 正文字体
#define HZStatusCellContentFont [UIFont systemFontOfSize:14]
// 转发微博正文
#define HZStatusCellRetweetContentFont [UIFont systemFontOfSize:14]

//cell的边框宽度
#define HZStatusCellBorderW 10

//cell的边框间距
#define HZStatusCellMARGIN 10


@class HZStatus;
@interface HZStatusFrame : NSObject

@property(strong,nonatomic) HZStatus * status;

/*原创微博*/
//**微博整体*/
@property(assign,nonatomic) CGRect originalViewF;
//**头像*/
@property(assign,nonatomic) CGRect iconViewF;
//**会员图标*/
@property(assign,nonatomic) CGRect vipViewF;
//**配图*/
@property(assign,nonatomic) CGRect photosViewF;
//**昵称*/
@property(assign,nonatomic) CGRect nameLabelF;
//**时间*/
@property(assign,nonatomic) CGRect timeLabelF;
//**来源*/
@property(assign,nonatomic) CGRect sourceLabelF;
//**正文*/
@property(assign,nonatomic) CGRect contentLabelF;
//*cell的高度*/
@property(assign,nonatomic) CGFloat cellHeight;



/*转发微博*/

/**转发微博整体*/
@property(assign,nonatomic) CGRect  retweetViewF;
/**昵称 + 正文*/
@property(assign,nonatomic) CGRect  retweetContentLabelF;
/**转发配图*/
@property(assign,nonatomic) CGRect  retweetPhotosViewF;

/**工具条*/
@property(assign,nonatomic) CGRect  toolBarF;

@end
