//
//  HZStatus.m
//  华仔微博2期
//
//  Created by tarena on 15/8/10.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZStatus.h"
#import "MJExtension.h"
#import "HZPhoto.h"
#import "NSDate+Extension.h"
@implementation HZStatus
-(NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [HZPhoto class]};
}

/**
 *  时间
 */
-(NSString *)created_at
{
    // _created_at == Thu Oct 16 17:06:25 +0800 2014
    // dateFormat == EEE MMM dd HH:mm:ss Z yyyy
    // NSString --> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    // 如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale= [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式（声明字符串里面每个数字和单词的含义）
    
    // EEE:星期几
    // MMM:月份
    // dD:几号(这个月的第几天)
    // HH:24小时制的小时
    // mm:分钟
    // ss:秒
    // yyyy:年
    // Z :时区
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //微博创建时间
    
    NSDate *createDate = [fmt dateFromString:_created_at];
//当前时间
    NSDate *now = [NSDate date];
    // 日历对象（方便比较两个日期之间的差距）
    NSCalendar *calender = [NSCalendar currentCalendar];
    //NSCalendarUnit枚举代表想获得那些差值
    NSCalendarUnit unit = NSCalendarUnitYear |  NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calender components:unit fromDate:createDate toDate:now options:0];


    if ([createDate isThisYear]){//今年
        if ([createDate isThisYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];

        }else if ([createDate isThisToday]){//今天
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%ld小时前",(long)cmps.hour];
            }else if (cmps.minute >= 2){
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{//今天的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{//非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}



/**
 *  数据源显示
 */

//  <a href="http://weibo.com/" rel="nofollow">微博 weibo.com</a>

//- (void)setSource:(NSString *)source
//{
//    // 正则表达式 NSRegularExpression
//    
//    // 截串 NSString
//    NSRange range;
//    range.location = [source rangeOfString:@">"].location + 1;
////    range.length = [source rangeOfString:@"</"].location - (range.location);
//    range.length = [source rangeOfString:@"<" options:NSBackwardsSearch].location - range.location;
//    NSLog(@"%@",source);
//    _source = [NSString stringWithFormat:@"来自%@", [source substringWithRange:range]];
////
//}
//















@end
