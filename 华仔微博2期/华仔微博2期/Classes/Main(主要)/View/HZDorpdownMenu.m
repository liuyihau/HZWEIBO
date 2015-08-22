//
//  HZDorpdownMenu.m
//  华仔微博2期
//
//  Created by tarena on 15/8/6.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZDorpdownMenu.h"

@interface HZDorpdownMenu()

/**
 *  将来用来显示具体内容的容器
 */
@property(weak,nonatomic)UIImageView * containerView;

@end

@implementation HZDorpdownMenu


-(UIImageView *)containerView
{
    if (!_containerView) {
        //添加一个灰色图片
        UIImageView *containerView = [[UIImageView alloc]init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
//        containerView.width = 217;
//        containerView.height = 217;
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
        
    }
    return _containerView;
}


/**
 *  显示
 *
 *  @return Menu
 */

+(instancetype)Menu
{
    HZDorpdownMenu *Menu = [[HZDorpdownMenu alloc]init];
    // 清除颜色
            Menu.backgroundColor = [UIColor clearColor];
    return Menu;
}

//重写set方法
-(void)setContent:(UIView *)content
{
    _content = content;
    //添加内容到灰色图片
    content.x = 10;
    content.y = 15;
    
    //调证内容的宽度
//    content.width = self.containerView.width - 2*content.x;
    
    //设置灰色图片的高度
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    //设置灰色的宽度
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    
    
    
      [self.containerView addSubview:content];
   
}



-(void)setContentViewController:(UIViewController *)contentViewController
{
    _contentViewController = contentViewController;

    self.content = contentViewController.view;
    
    
}







/**
 *  显示到窗口
 */
-(void)showFrom:(UIView *)from
{
    //1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //2.显示自己
    [window addSubview:self];
    
    //3.设置尺寸
    self.frame = window.bounds;
    
    //4.调整灰色图片的位置
    self.containerView.x = (self.width - self.containerView.width) *0.5;
    
//默认情况下，frame是以父控件右上角为坐标原点
//可以转换坐标系
    CGRect newFrame = [from convertRect:from.bounds toView:window];

    self.containerView.y = CGRectGetMaxY(newFrame);
    
    /**
     *  通知外界自己显示了
     */
    
    if ([self.delegate respondsToSelector:@selector(dorpdownMenuDidShow:)]) {
        [self.delegate dorpdownMenuDidShow:self];
    }
    
    
}





/**
 *  销毁
 */
-(void)dismiss
{

    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dorpdownMenuDidDismiss:)]) {
        [self.delegate dorpdownMenuDidDismiss:self];
    }
    

    
    
}

/**
 *  点击销毁
 *
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [self dismiss];

}




@end
