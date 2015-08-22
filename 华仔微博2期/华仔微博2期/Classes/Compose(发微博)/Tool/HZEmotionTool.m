//
//  HZEmotionTool.m
//  华仔微博2期
//
//  Created by tarena on 15/8/19.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

//最近表情的存储路径


#define HZRecentEmotionPath  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"emotion.achive"]

#import "HZEmotionTool.h"
#import "HZEmotion.h"
@implementation HZEmotionTool
static NSMutableArray *_recetEmotions;

+(void)initialize
{
    //加载沙盒中的数据
    _recetEmotions = [NSKeyedUnarchiver unarchiveObjectWithFile:HZRecentEmotionPath];
    if (_recetEmotions == nil) {
        _recetEmotions = [NSMutableArray array];
    }
}

+(void)addEmotion:(HZEmotion *)emotion
{
    //删除重复的表情
    [_recetEmotions removeObject:emotion];
    
    //将表情放到数组的最前面
    [_recetEmotions  insertObject:emotion atIndex:0];
    
    //将所有的表情数据写入到沙盒
    [NSKeyedArchiver archiveRootObject:_recetEmotions toFile:HZRecentEmotionPath];
}
/**
 *  返回转着HZEmotion模型的数组
 */
+(NSArray *)recentEmotions
{
    return _recetEmotions;
}
//删除重复的表情 方法二
//    for (int i = 0; i < emotions.count; i++) {
//        HZEmotion *e = emotions[i];
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//        }
//    }
//删除重复的表情 方法三
//     for (HZEmotion *e in emotions) {
//
//        if ([e.chs isEqualToString:emotion.chs] || [e.code isEqualToString:emotion.code]) {
//            [emotions removeObject:e];
//            break;
//          }
//
//    }


@end
