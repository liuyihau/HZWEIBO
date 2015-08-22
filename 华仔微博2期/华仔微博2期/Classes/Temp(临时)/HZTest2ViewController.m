//
//  HZTest2ViewController.m
//  华仔微博2期
//
//  Created by tarena on 15/8/5.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZTest2ViewController.h"
#import "HZTest3TableViewController.h"

@interface HZTest2ViewController ()

@end

@implementation HZTest2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    HZTest3TableViewController *test3 =[[HZTest3TableViewController alloc]init];
    test3.title = @"test3测试控制器";
    test3.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:test3 animated:YES];


}



@end
