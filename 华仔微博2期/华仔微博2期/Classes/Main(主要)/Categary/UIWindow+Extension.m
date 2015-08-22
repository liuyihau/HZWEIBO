//
//  UIWindow+Extension.m
//  华仔微博2期
//
//  Created by tarena on 15/8/8.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "HZTabBarViewController.h"
#import "HZNewfeatureViewController.h"

@implementation UIWindow (Extension)


- (void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    //上一次使用的版本（存在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
    //当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    if ([currentVersion isEqualToString:lastVersion]) {//版本号相同，这次打开和上次打开的是同一个版本
        
        self.rootViewController =  [[HZTabBarViewController alloc]init];
        
    }else{//这一次打开的版本和上一次的不一样，显示新特性
        
        self.rootViewController = [[HZNewfeatureViewController alloc]init];
        
        //将当前的版本号存储的沙盒中
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
