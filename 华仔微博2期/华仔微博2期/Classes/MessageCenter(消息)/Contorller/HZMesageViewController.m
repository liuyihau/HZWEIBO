//
//  HZMesageViewController.m
//  华仔微博2期
//
//  Created by tarena on 15/8/4.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZMesageViewController.h"
#import "HZTest1ViewController.h"

@interface HZMesageViewController ()

@end

@implementation HZMesageViewController

- (void)viewDidLoad {
    
    
    [super viewDidLoad];
    
    //style是用来设置效果的，但在iOS7后整体偏平化设计 在iOS7 之前效果明显，iOS7 之后没有任何效果
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
 
}


-(void)viewWillAppear:(BOOL)animated{
//这个item不能点击(就能显示在disable下)
    self.navigationItem.rightBarButtonItem.enabled = NO;


}



-(void)composeMsg
{
    HZLog(@"发私信");

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"test-message-%ld", (long)indexPath.row];
    
    
    return cell;
}


#pragma mark -- table代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    HZTest1ViewController *test1 = [[HZTest1ViewController alloc]init];
    test1.title = @"测试控制器1";
    
    // 当test1控制器被push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
    // 当test1控制器被pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
    
    test1.hidesBottomBarWhenPushed = YES ;
    
    [self.navigationController pushViewController:test1 animated:YES];


}


@end
