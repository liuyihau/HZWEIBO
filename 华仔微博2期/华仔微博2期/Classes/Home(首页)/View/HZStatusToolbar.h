//
//  HZStatusToolbar.h
//  华仔微博2期
//
//  Created by tarena on 15/8/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZStatus.h"
@interface HZStatusToolbar : UIView
+(instancetype)HZToolbar;
@property(strong,nonatomic)HZStatus *status;


@end
