//
//  HZEmotionPageView.m
//  华仔微博2期
//
//  Created by tarena on 15/8/18.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZEmotionPageView.h"
#import "HZEmotion.h"
#import "NSString+Emoji.h"
#import "HZEmotionPopView.h"
#import "HZEmotionButton.h"
#import "HZEmotionTool.h"

@interface  HZEmotionPageView()
/**
 *  点击按钮后弹出的放大镜
 */
@property(strong,nonatomic)HZEmotionPopView * popView;
/**
 *  删除按钮
 */
@property(weak,nonatomic)UIButton *deleteBtn;



@end

@implementation HZEmotionPageView

//懒加载
- (HZEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [HZEmotionPopView popView];
    }
    return _popView;
}


#pragma mark -- 初始化
-(instancetype)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        //1.删除按钮
        UIButton *deleteBtn = [[UIButton alloc]init];
        [deleteBtn  setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState: UIControlStateNormal];
        [deleteBtn setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:deleteBtn];
        [deleteBtn addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        self.deleteBtn = deleteBtn;
        
        //2.添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressPageView:)]];
                
    }
    return self;

}
/**
 *  根据手指位置，找到表情按钮
 *
 */
-(HZEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        HZEmotionButton *btn = self.subviews[i +1];
        if (CGRectContainsPoint(btn.frame, location)) {
            
            //已经找到手指所在的表情按钮了，就没有必要再往下遍历
            return btn;
        }
    }
    return nil;

}

/**
 *  在这个方法中处理长按手势
 *
 */
-(void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    //获得手指所在位置\所在的表情按钮
    HZEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateEnded://长按手势结束,手指不在触摸pageView
        case UIGestureRecognizerStateCancelled :
            //移除popView
            [self.popView removeFromSuperview];
            if (btn) {
                //发出通知
                [self selectEmotion:btn.emotion];
             }
            
            break;
            
        case UIGestureRecognizerStateBegan://长按手势开始
        case UIGestureRecognizerStateChanged:{//长按手势改变
        
            [self.popView showFrom:btn];

            break;
        }
            
        default:
            break;
            
    }
    
        
        
    

}

/**
 *  创建表情按钮
 *
 */
-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        HZEmotionButton *btn = [[HZEmotionButton alloc]init];
        [self addSubview:btn];
        //设置表情数据
        btn.emotion =emotions[i];
               
        //监听按钮的点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
  }

}



// CUICatalog: Invalid asset name supplied: (null), or invalid scale factor: 2.000000
// 警告原因：尝试去加载的图片不存在



-(void)layoutSubviews
{
    [super layoutSubviews];
    //内边距四周
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW =(self.width - 2 * inset) /HZEmotionMaxCols ;
    CGFloat btnH =(self.height - inset) / HZEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i+1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % HZEmotionMaxCols) * btnW;
        btn.y = inset + (i / HZEmotionMaxCols) * btnH;
        
        
    //删除按钮
        self.deleteBtn.width = btnW;
        self.deleteBtn.height = btnH;
        self.deleteBtn.x = self.width - inset - btnW;
        self.deleteBtn.y = self.height - btnH;
    
        
        
    }
}

/**
 *  监听删除按钮点击
 */
-(void)deleteClick
{

    //发出删除通知
    [HZNotificationCenter postNotificationName:HZEmotionDidDeleteNotification object:nil];


}



/**
 *  监听表情按钮点击
 *
 *  @param btn 被点击的表情按钮
 */
-(void)btnClick:( HZEmotionButton *)btn
{
    
    //显示popView
    [self.popView showFrom:btn];
    
    
    //等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       
        [self.popView removeFromSuperview];

    });
    
    
    
    //发出通知
    [self selectEmotion:btn.emotion];
}


/**
 *  选中某个表情，发出通知
 *
 *  @param emotion 被选中的表情
 */
-(void)selectEmotion:(HZEmotion *)emotion
{
    //将这个表情存进按钮
    [HZEmotionTool addEmotion:emotion];
    
    
    
    //发出的通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[HZSelectEmotionKey] = emotion;
    [HZNotificationCenter postNotificationName:HZEmotionDidSelectNotification object:nil userInfo:userInfo];

}




@end
