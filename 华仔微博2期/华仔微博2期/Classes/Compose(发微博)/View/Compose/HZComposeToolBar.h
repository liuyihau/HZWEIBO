//
//  HZComposeToolBar.h
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    
    HZComposeToolBarButtonTypeCamera,//拍照
    HZComposeToolBarButtonTypePicture,//相册
    HZComposeToolBarButtonTypeMention,//@
    HZComposeToolBarButtonTypeTrend,//#
    HZComposeToolBarButtonTypeEmotion//表情
    
}HZComposeToolBarButtonType;


@class HZComposeToolBar;
@protocol HZComposeToolbarDelegate <NSObject>
@optional
-(void)composeToolbar:(HZComposeToolBar *)toolbar didClickButton:(HZComposeToolBarButtonType)butonnType;


@end
@interface HZComposeToolBar : UIView

@property(weak,nonatomic) id<HZComposeToolbarDelegate> delegate;
/**
 *  是否要显示键盘
 */
@property(assign,nonatomic) BOOL showKeyboardButton;

@end
