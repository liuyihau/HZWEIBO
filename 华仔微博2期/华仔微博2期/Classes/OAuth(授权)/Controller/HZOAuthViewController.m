//
//  HZOAuthViewController.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/7.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZOAuthViewController.h"
#import "HZHttpTool.h"
#import "HZAccount.h"
#import "MBProgressHUD+MJ.h"
#import "HZAccountTool.h"
#import "UIWindow+Extension.h"

@interface HZOAuthViewController ()<UIWebViewDelegate>

@end

@implementation HZOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建一个webView
    UIWebView * webView = [[UIWebView alloc]init];
    
    webView.frame = self.view.bounds;
    //设置代理
    webView.delegate = self;
    
    [self.view addSubview:webView];
    
    
    
    //2.用webView加载登陆页面（新浪提供的）
    
    //请求地址："https://api.weibo.com/oauth2/authorize?client_id=4046057657&redirect_uri=http://"
    //请求参数：
    //client_id	true	string	申请应用时分配的AppKey。
    //redirect_uri	true	string	授权回调地址，站外应用需与设置的回调地址一致，站内应用需填写canvas page的地址。
    
    
    NSURL *url = [NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=4046057657&redirect_uri=http://"];
    
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
  
    [webView loadRequest:request];
    


}

#pragma mark -- webView 代理方法

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
//    NSLog(@"------webViewDidStartLoad");
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
//    NSLog(@"------webViewDidFinishLoad");
    [MBProgressHUD hideHUD];
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];


}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //1.获得URL
    NSString *url = request.URL.absoluteString;
    
    //2.判断是否为回调地址
    NSRange range = [url rangeOfString:@"code="];
    if (range.length != 0) {//是回调地址
        //截取code=后面的参数值
        long fromIndex = range.location + range.length;
        NSString * code = [url substringFromIndex:fromIndex];
   
        
        
    //利用code换取一个Access Token
        [self accessTokenWithCode:code];
        
    //禁止回调页面
        return NO;
        
        
    }
       return YES;
}

/**
 *  利用code（授权成功后的 request token）换取一个accessToken
 *
 */
-(void)accessTokenWithCode:(NSString *)code
{
    /**
     URL：https://api.weibo.com/oauth2/access_token
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */

    //1.拼接请求参数
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"client_id"] = @"4046057657";
    params[@"client_secret"] = @"36fa2a3e81f77576fff281ffb501fe5e";
    params[@"grant_type"] = @"authorization_code";
    params[@"redirect_uri"] = @"http://";
    params[@"code"] = code;
    
    //2.发送请求
    [HZHttpTool Post:@"https://api.weibo.com/oauth2/access_token" params:params success:^(id json) {
        
        //将返回的账号字典数据转成模型------存进沙盒
        HZAccount *account = [HZAccount accountWithDict:json];
        //存储账号信息
        [HZAccountTool saveAccout:account];
        
        //切换根控制器
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window switchRootViewController];
        //UIWindow的分类、HZWindowTool
        //UIViewController的分类、HWConterTool

    } failure:^(NSError *error) {
        [MBProgressHUD hideHUD];
        NSLog(@"请求失败%@-----",error.userInfo);

    }];
    
    
    //刘以华_iOS 微博
    /*
     2015-08-08 10:43:07.165 华仔微博2期[1953:62547] 请求成功{
     
     "access_token" = "2.00lcTsaCT7qo6Ef5c1a2af98mjypUE";
     
     "expires_in" = 145081;
     "remind_in" = 145081;
     uid = 2377197351;
     }
     */
    
    
    //liuyihua_ios 微博
    /*
     2015-08-08 10:57:21.861 华仔微博2期[2187:70698] 请求成功{
     "access_token" = "2.008ppdHGT7qo6E80d9b27ab7RNTNIC";
     "expires_in" = 157679999;
     "remind_in" = 157679999;
     uid = 5609725369;
     }-----
     */
    
}



@end
