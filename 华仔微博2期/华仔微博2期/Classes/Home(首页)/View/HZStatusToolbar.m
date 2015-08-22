//
//  HZStatusToolbar.m
//  华仔微博2期
//
//  Created by tarena on 15/8/12.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZStatusToolbar.h"
#import "HZStatus.h"

@interface HZStatusToolbar()
//按钮数组
@property(strong,nonatomic)NSMutableArray *btns;
//分割线数组
@property(strong,nonatomic)NSMutableArray *dividers;

@property(weak,nonatomic)UIButton *retweetBtn;
@property(weak,nonatomic)UIButton *commentBtn;
@property(weak,nonatomic)UIButton *attitudeBtn;

@end
@implementation HZStatusToolbar

//懒加载
- (NSMutableArray *)btns
{
    if (!_btns) {
        _btns = [[NSMutableArray alloc] init];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        _dividers = [[NSMutableArray alloc] init];
    }
    return _dividers;
}

+(instancetype)HZToolbar
{
    
    return [[self alloc]init];
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        self.retweetBtn = [self setupBtnWithTitle:@"转发" image:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtnWithTitle:@"评论" image:@"timeline_icon_comment"];
        self.attitudeBtn =  [self setupBtnWithTitle:@"赞" image:@"timeline_icon_unlike"];
        
        //添加分割线
        [self setupDivider];
        [self setupDivider];
        
    }
    return self;

}
/**
 *  //添加分割线
 */
-(void)setupDivider
{
    UIImageView *divder = [[UIImageView alloc]init];
    divder.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divder];
    [self.dividers addObject:divder];
}

/**
 *  初始化按钮
 *
 *  @param title 按钮文字
 *  @param image 按钮图片
 */
-(UIButton *)setupBtnWithTitle:(NSString *)title image:(NSString *)image
{
     UIButton *btn = [[UIButton alloc]init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    [self.btns addObject:btn];
    return btn;
}


-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮的frame
    int bntCount = (int)self.btns.count;
    CGFloat btnW = self.width/bntCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < bntCount; i++) {
        UIButton *btn = self.btns[i];
        btn.x = i * btnW;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    //设置分割线的frame
    
    int dividerCount = (int)self.dividers.count;
    for (int i = 0; i < dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.x = (i + 1) *btnW;
        divider.y = 0;
        divider.height = btnH;
        divider.width = 1;
        
    }
    
}
/**
 *  返回解析的转发数、评论数和点赞数
 *
 */
-(void)setStatus:(HZStatus *)status{
    _status =status;


//    NSString * comments_count = [NSString stringWithFormat:@"%d",status.comments_count];
//    [self.commentBtn setTitle:comments_count forState:UIControlStateNormal];


    [self setupBntCount:status.reposts_count btn:self.retweetBtn title:@"转发"];
    [self setupBntCount:status.comments_count btn:self.commentBtn title:@"评论"];
    [self setupBntCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];

}

-(void)setupBntCount:(int)count btn:(UIButton *)btn title:(NSString *)title
{
    if (count) {
        if (count < 10000) {
             title = [NSString stringWithFormat:@"%d",count];
        }else{
            double wan = count / 10000.0;
            title = [NSString stringWithFormat:@"%.1f万", wan];
            // 将字符串里面的.0去掉
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }
        
    }
    
    [btn setTitle:title forState:UIControlStateNormal];
    
}




@end
