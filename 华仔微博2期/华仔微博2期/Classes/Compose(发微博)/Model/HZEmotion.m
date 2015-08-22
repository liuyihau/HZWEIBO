//
//  HZEmotion.m
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotion.h"
#import "MJExtension.h"
@interface HZEmotion()<NSCoding>

@end
@implementation HZEmotion

//MJCodingImplementation

/**
 *  从文件中解析对象时调用
 *
 */
-(id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        
        self.chs = [decoder decodeObjectForKey:@"chs"];
        self.png = [decoder decodeObjectForKey:@"png"];
        self.code = [decoder decodeObjectForKey:@"code"];
    }
    
    return self;
}
/**
 *  将文件写入文件时调用
 *
 */
-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.chs forKey:@"chs"];
    [encoder encodeObject:self.png forKey:@"png"];
    [encoder encodeObject:self.code forKey:@"code"];

}

/**
 *  常用来比较两个对象是否一样

 *
 *  @param object 另外一个HZEmotion对象
 *
 *  @return YES：代表2个对象是一样的； NO：代表2个对象不一样
 */
-(BOOL)isEqual:(HZEmotion *)other
{
//    HZLog(@"%@- --- isEqle --- %@",self.chs,other.chs);
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];

}


@end
