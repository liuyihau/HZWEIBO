//
//  HZNewfeatureViewController.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/7.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZNewfeatureViewController.h"
#import "HZTabBarViewController.h"


#define HZNewfeatureCount 4
@interface HZNewfeatureViewController ()<UIScrollViewDelegate>
@property(weak,nonatomic)UIPageControl * pageControl;
@end

@implementation HZNewfeatureViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    //1.创建scrollVeiw
    UIScrollView * scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    
    
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    //2.添加图片到scrollView
    for (int i = 0; i < HZNewfeatureCount; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i *scrollW;
        
        //显示图片
        NSString * name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        //如果是最后一个imageView,就往里面添加其他内容
        if (i == HZNewfeatureCount - 1) {
            [self setupLastImageView:imageView];
        }
        
#warning 默认情况下，scrollView一旦创建出来，里面可能就存在一些子控件
#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
        
        
        
        
    }
    
    //3.设置scrollView的其他属性
    
    //如果想要某个方向上不能滚动，那么这个方向对应的尺寸数值就为0
    scrollView.contentSize = CGSizeMake(HZNewfeatureCount *scrollW, 0);
    //去除弹簧效果
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    
    //设置代理
    scrollView.delegate = self;
    
    
    //4.添加pageControl:分页，展示目前看的第几页
     UIPageControl * pageControl = [[UIPageControl alloc]init];
    pageControl.numberOfPages = HZNewfeatureCount;
    pageControl.currentPageIndicatorTintColor = HZColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = HZColor(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50 ;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl ;
    
    /**
     *  UIPageControl 就算没有设置尺寸，里面的内容还是照常显示的
     */
    
    //    pageControl.width = 100;
    //    pageControl.height = 50;
    //    pageControl.userInteractionEnabled = NO;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    
    self.pageControl.currentPage = (int)(page + 0.5);
    
    //int （page + 0.5）
}


-(void)setupLastImageView:(UIImageView *)imageView
{
    //开启交互功能
    imageView.userInteractionEnabled = YES;
    
    
    //1.分享给大家 （checkbox）
    UIButton *shareBtn = [[UIButton alloc]init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.width = 200;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width * 0.5;
    shareBtn.centerY = imageView.height *0.65;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    [imageView addSubview:shareBtn];
    
//    shareBtn.backgroundColor  =[UIColor redColor];
//    shareBtn.imageView.backgroundColor = [UIColor yellowColor];
//    shareBtn.titleLabel.backgroundColor = [UIColor blueColor];

    
//    top left bottom right
//    EdgeInsets : 自切
//    shareBtn.contentEdgeInsets :会影响按钮内部的所有内容（里面的imageView和titleLabel）
//    shareBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 0, 0, 0);
    
//    shareBtn.imageEdgeInsets ： 只会影响按钮内部的imageView
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
//    shareBtn.titleEdgeInsets : 只会影响按钮内部的titleLabel
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    //2.开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = imageView.width * 0.5;
    startBtn.centerY = imageView.height *0.73;
     [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    
    [imageView addSubview:startBtn];
    

}


//开始微博
-(void)startClick
{

    //切换到HZTabBarController
    /*切换控制器的手段
    1.push :依赖于UINavigationControler,控制器的切换是可逆的，比如A切换到B ，B可以回到A；
    2.model
    3.切换window 的rootViewController
    */
    
      UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    window.rootViewController = [[HZTabBarViewController alloc]init];
}




//分享给大家
-(void)shareClick:(UIButton *)shareBtn
{
    shareBtn.selected = !shareBtn.isSelected;
}

@end
