//
//  HZEmotionTextView.m
//  华仔微博2期
//
//  Created by tarena on 15/8/19.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionTextView.h"
#import "HZEmotion.h"
#import "UITextView+Extension.h"
#import "HZEmotionAttachment.h"
@implementation HZEmotionTextView

-(void)insertEmotion:(HZEmotion *)emotion
{
    
    if (emotion.code) {//emoji
    
        [self insertText:emotion.code.emoji];
        
    }else if (emotion.png){//图片
        
        //加载图片
        HZEmotionAttachment *attch = [[HZEmotionAttachment alloc]init];
        //传递模型
        attch.emotion = emotion;
        //设置图片尺寸
        CGFloat attchWH = self.font.lineHeight;
        attch.bounds = CGRectMake(0, -4, attchWH, attchWH);

                
        //根据附件创建一个属性文字
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        
        //设置字体
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *attributedText) {
            
            [attributedText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, attributedText.length)];

        }];
 
    }
}

-(NSString *)fullText
{
    NSMutableString *fullText = [NSMutableString string];
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
       
        
       //如果是图片
        HZEmotionAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {//图片
            [fullText appendString:attch.emotion.chs];
            
            
            
        }else{//emoji、普通文本
            //获得这个范围内的文字
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
            
        }
        
    
    }];
    
    
    
    return fullText;
}
@end
