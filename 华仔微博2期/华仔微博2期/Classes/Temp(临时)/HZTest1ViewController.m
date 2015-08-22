//
//  HZTest1ViewController.m
//  华仔微博2期
//
//  Created by tarena on 15/8/5.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZTest1ViewController.h"
#import "HZTest2ViewController.h"

@interface HZTest1ViewController ()

@end

@implementation HZTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
        
    HZTest2ViewController *test2 = [[HZTest2ViewController alloc]init];
    test2.title = @"test测试控制器";
    test2.hidesBottomBarWhenPushed = YES ;
    [self.navigationController pushViewController:test2 animated:YES];
        
}
    






@end
