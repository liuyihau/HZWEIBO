//
//  HZHomeViewController.m
//  华仔微博2期
//
//  Created by tarena on 15/8/4.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZHomeViewController.h"
#import "HZDorpdownMenu.h"
#import "HZTitleMenuViewController.h"
#import "HZHttpTool.h"
#import "HZAccountTool.h"
#import "HZTitleButton.h"
#import "UIImageView+WebCache.h"
#import "HZUser.h"
#import "HZStatus.h"
#import "MJExtension.h"
#import "HZlLoadMoreFooter.h"
#import "HZStatusCell.h"
#import "HZStatusFrame.h"
#import "MJRefresh.h"

@interface HZHomeViewController ()<HZDorpdownMenuDelegate>
/**
 *  微博数组(里面放的都是HZStatusFrame模型，一个HZStatusFrame就代表一条微博)
 */
@property(strong,nonatomic)NSMutableArray *statusFrames;

@end

@implementation HZHomeViewController

// 懒加载
- (NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames= [[NSMutableArray alloc] init];
    }
    return _statusFrames;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //设置导航栏按钮
    [self setupNav];
    
    //获取用户信息
    [self setupUserInfo];
    
    //集成下拉刷新控件
    [self setupDownRefresh];
    
    //集成上拉刷新控件
    [self setupUpRefresh];
    
    //tableView分割线
    self.tableView.separatorColor = [UIColor colorWithWhite:0 alpha:0];
    
    // 获得未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
    
    // 主线程也会抽时间处理一下timer（不管主线程是否正在其他事件）
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

/**
 *  获得未读数
 */

- (void)setupUnreadCount
{
    
    //通知：NSNotification 不可见
    //本地通知
    //远程推送通知
    
    // 1.拼接请求参数
    HZAccount *account = [HZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 2.发送请求
    [HZHttpTool Get:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        NSString *status = [json[@"status"] description];
        
        if ([status isEqualToString:@"0"]) { // 如果是0，得清空数字
            self.tabBarItem.badgeValue = nil;
            
            
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else { // 非0情况
            
            self.tabBarItem.badgeValue = status;
            
            [UIApplication sharedApplication].applicationIconBadgeNumber =status.intValue;
        }

    } failure:^(NSError *error) {
        HZLog(@"1请求失败-%@", error);

    }];
        
//        // 微博的未读数
//                int status = [responseObject[@"status"] intValue];
//        // 设置提醒数字
//                self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", status];
        
        // @20 --> @"20"
        // NSNumber --> NSString
        //设置提醒数字(微博的未读数)
        
}

/**
 *  集成上拉刷新控件
 */
-(void)setupUpRefresh
{

//    [self.tableView addFooterWithCallback:^{
//        
//        NSLog(@"yeshi");
//    }];
    
    [self.tableView addFooterWithTarget:self action:@selector(loadMoreStatus)];
}

/**
 *  加载更多的微博数据
 */
- (void)loadMoreStatus
{
    // 1.拼接请求参数
    HZAccount *account = [HZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    // 取出最后面的微博（最新的微博，ID最大的微博）
    HZStatusFrame *lastStatus = [self.statusFrames lastObject];
    if (lastStatus) {
        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
        long long maxId = lastStatus.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    // 2.发送请求
    [HZHttpTool Get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        // 将 "微博字典"数组 转为 "微博模型"数组
        NSArray *newStatuses = [HZStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        
        // 将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
        
        // 将更多的微博数据，添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新(隐藏footer)

        [self.tableView footerEndRefreshing];
        
    } failure:^(NSError *error) {
        HZLog(@"2请求失败-%@", error);
        
        // 结束刷新
       [self.tableView footerEndRefreshing];

    }];
    
}


/**
 *  集成下拉刷新控件
 */
-(void)setupDownRefresh
{
    
    //1.添加刷新控件
  
    [self.tableView addHeaderWithTarget:self action:@selector(loadNewStatus)];
    
   //2.一进入就进行界面刷新
    [self.tableView headerBeginRefreshing];
}


/**
 *  将HWStatus模型转为HWStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (HZStatus *status in statuses) {
        HZStatusFrame *f = [[HZStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}


/**
 *  UIRefreshControl 进入刷新状态：加载最新的数据
 */
-(void)loadNewStatus
{
    //1.拼接请求参数
    HZAccount *account = [HZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
     HZStatusFrame *firstStatusF = [self.statusFrames firstObject];
    
    if (firstStatusF) {
        //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        params[@"since_id"] = firstStatusF.status.idstr;
    }
   
    //2.发送请求
    [HZHttpTool Get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
        //将“微博字典”数组 转 “微博模型”数组
        NSArray *newStatuesArray = [HZStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
        //将 HZStatus数组 转为 HZStatusFrames数组
        NSArray *newFrames = [self stausFramesWithStatuses:newStatuesArray];
        //将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set =[NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        //刷新表格
        [self.tableView reloadData];
        //结束刷新
        [self.tableView headerEndRefreshing];
        //显示最新微博的数量
        [self showNewStatusCount:(int)newStatuesArray.count];
  
    } failure:^(NSError *error) {
        HZLog(@"请求失败%@-----",error.userInfo);
        //结束刷新
       [self.tableView headerEndRefreshing];
    }];
   }

/**
 *  //显示最新微博的数量
 */
-(void)showNewStatusCount:(int)count
{   // 刷新成功(清空图标数字)
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    //1.创建label
    UILabel *label = [[UILabel alloc]init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    //2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    }else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    
    //3.添加
    label.y = 64 - label.height;
    
//   将label添加到导航控制器的view中，并且盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4.动画
    //先利用1S的时间，让label往下移动一段距离
    CGFloat duration = 1.0;
    [UIView animateWithDuration:duration animations:^{
        
//        label.y += label.height;
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
        
    } completion:^(BOOL finished) {
        
        //延迟1s后 先利用1S的时间，让label回到原来的状态
        CGFloat delay = 1.0;//延迟1秒
        
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            
//             label.y -= label.height;
            
            label.transform = CGAffineTransformIdentity;
            
        } completion:^(BOOL finished) {
             [label removeFromSuperview];
        }];
    }];

    // 如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}

/**
 *  获取用户信息
 */
-(void)setupUserInfo
{
    /*
    GET请求： URL:https://api.weibo.com/2/users/show.json
     
    uid	            false	int64	需要查询的用户ID。
    access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
    */

    //1.拼接请求参数
    HZAccount *account = [HZAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uid"] = account.uid;
    params[@"access_token"] = account.access_token;
    
    //2.发送请求
    [HZHttpTool Get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        //设置标题
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        //设置名字
        //在字典转模型
        HZUser *user = [HZUser objectWithKeyValues:json];
        NSString *name =user.name;
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        //将账户名称存储到沙盒
        account.name = name;
        [HZAccountTool saveAccout:account];
        

    } failure:^(NSError *error) {
       HZLog(@"请求失败%@-----",error.userInfo);
    }];
    
    

}

/**
 *  设置导航栏按钮
 */
-(void)setupNav
{
    //设置导航栏按钮
    self.navigationItem.leftBarButtonItem =[UIBarButtonItem itmeWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" HighliImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itmeWithTarget:self action:@selector(pop) image:@"navigationbar_pop" HighliImage:@"navigationbar_pop_highlighted"];
    
    //中间标题按钮
    HZTitleButton * titleButton = [[HZTitleButton alloc]init];
    //设置图片和文字
     NSString *name = [HZAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    //监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:
     UIControlEventTouchUpInside];
    

    
     self.navigationItem.titleView = titleButton;
}

/**
 *  标题点击
 */
-(void)titleClick:(UIButton *)titleButton
{
    //1.创建下拉菜单
    HZDorpdownMenu *Menu =[HZDorpdownMenu Menu];
    
    //设置代理
    Menu.delegate = self;
    
    //2.设置内容
    //提交高度
//    Menu.content = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 217)];
    
    HZTitleMenuViewController *vc = [[HZTitleMenuViewController alloc]init];
    
    vc.view.height = 44 *3;
    vc.view.width = 150;
    
    Menu.contentViewController = vc;
    
    
    //3.显示下拉菜单
    [Menu showFrom:titleButton];
}

-(void)friendsearch
{
    NSLog(@"搜索好友");
}

-(void)pop
{
    NSLog(@"扫描");

}


#pragma mark -- Table View data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    //取出Cell
    HZStatusCell *cell = [HZStatusCell cellWithTableView:tableView];

    //给cell传递微博数据
    
    cell.statusFrame = self.statusFrames[indexPath.row];
    
    return cell;
}
/**
 *  1.将字典转化成模型
 *  2.能够下拉刷新最新的微博数据
 *  3.能够上拉加载更多地微博数据
 */

#pragma mark -- HZDorpdownMenuDelegate

-(void)dorpdownMenuDidDismiss:(HZDorpdownMenu *)Menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = NO;
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
   
}

-(void)dorpdownMenuDidShow:(HZDorpdownMenu *)Menu
{

    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
//    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZStatusFrame *frame = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}


@end
