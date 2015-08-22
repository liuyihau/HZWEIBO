//
//  HZStatusCell.h
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZStatusFrame;

@interface HZStatusCell : UITableViewCell

+(instancetype)cellWithTableView:(UITableView *)tableView;

@property(strong,nonatomic) HZStatusFrame * statusFrame;

@end
