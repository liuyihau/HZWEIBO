//
//  HZComposeViewController.m
//  华仔微博2期
//
//  Created by liuyihua on 15/8/16.
//  Copyright (c) 2015年 tarena. All rights reserved.
//

#import "HZComposeViewController.h"
#import "HZEmotionTextView.h"
#import "HZAccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HZComposeToolBar.h"
#import "HZComposePhotosView.h"
#import "HZEmotionKeyboard.h"
#import "HZEmotion.h"



@interface HZComposeViewController ()<UITextViewDelegate,HZComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  输入控件
 */
@property(weak,nonatomic) HZEmotionTextView * textView;
/**
 *  键盘顶部的工具条
 */
@property(weak,nonatomic) HZComposeToolBar * toolbar;
/**
 *  相册 （存放拍照或者相册中选择的图片）
 */
@property(weak,nonatomic) HZComposePhotosView * photosView;
/**
 *  表情键盘
 */
@property(strong,nonatomic)HZEmotionKeyboard *emotionKeyboard;
/**
 *  是否开始切换键盘
 */
@property(assign,nonatomic) BOOL switchingKeybaord;

@end

@implementation HZComposeViewController

#pragma mark -- 懒加载
//懒加载
- (HZEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[HZEmotionKeyboard alloc]init];
        self.emotionKeyboard.width = self.view.width;
        self.emotionKeyboard.height = 216;
        
    }
    return _emotionKeyboard;
}

#pragma mark -- 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    //设置导航栏内容
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
    //添加工具条
    [self setupToolbar];
    
    //添加TextView相册
    [self setPhotosView];
    
    
    
}

-(void)dealloc
{
    [HZNotificationCenter removeObserver:self];
}


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //成为第一相应者（能输入文本的控件一旦成为第一响应者，就会叫出相应的键盘）
    [self.textView becomeFirstResponder];


}

#pragma mark -- 初始化方法
/**
 *  添加相册
 */
-(void)setPhotosView
{
    HZComposePhotosView *photosView = [[HZComposePhotosView alloc]init];
   
    photosView.y = 100;
    photosView.width = self.view.width;
    //高度随便设置
    photosView.height = self.view.height;
    [self.textView addSubview:photosView];
    self.photosView = photosView;

}


/**
 *  添加工具调皮
 */
-(void)setupToolbar
{
    HZComposeToolBar *toolbar =[[HZComposeToolBar alloc]init];
    toolbar.height = 44;
    toolbar.width  = self.view.width;
    
//    self.textView.inputAccessoryView = toolbar;
    
    
    toolbar.y = self.view.height - toolbar.height;
    toolbar.delegate = self;
    
    
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
    

}

/**
 *  设置导航栏内容
 */
-(void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;


    NSString *name = [HZAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel * titleView = [[UILabel alloc]init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        //自动换行
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix,name];
        //创建一个带有属性的字符串（比如颜色属性、字体属性等文字属性）
        NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc]initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText  = attrStr;
        self.navigationItem.titleView = titleView;
        
    }else{
        self.title = prefix;
    
    }
    

}
/**
 *  // 添加输入控件
 */
-(void)setupTextView
{
    // 在这个控制器中，textView的contentInset.top默认会等于64
    HZEmotionTextView *textView = [[HZEmotionTextView alloc] init];
    textView.alwaysBounceVertical = YES;
    textView.frame = self.view.bounds;
    textView.font = [UIFont systemFontOfSize:15];
    textView.placeholder = @"分享新鲜事...";
    textView.delegate = self;
        
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    
    // 监听通知
    [HZNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];

    //键盘通知
    
    //   键盘的frame发生改变就发出通知（位置和尺寸）
    //   UIKeyboardWillChangeFrameNotification
    //   UIKeyboardDidChangeFrameNotification
    
    //   键盘显示时就发出通知
    //   UIKeyboardWillShowNotification;
    //   UIKeyboardDidShowNotification;
    
    //   键盘隐藏时就发出通知
    //   UIKeyboardWillHideNotification;
    //   UIKeyboardDidHideNotification;
    [HZNotificationCenter addObserver:self selector:@selector(KeyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    //表情选中的通知
    
    [HZNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:HZEmotionDidSelectNotification object:nil];
    
    //表情删除的通知
     [HZNotificationCenter addObserver:self selector:@selector(emotionDidDelete) name:HZEmotionDidDeleteNotification object:nil];
  

}

#pragma mark -- 监听方法
/**
 *  表情删除的监听方法
 */
-(void)emotionDidDelete
{
    [self.textView deleteBackward];

}



/**
 *  表情选中的监听方法
 */
-(void)emotionDidSelect:(NSNotification *)notification
{
    HZEmotion *emotion = notification.userInfo[HZSelectEmotionKey];
    
    [self.textView insertEmotion:emotion];
}


/**
 *  键盘切换时的监听方法
 */
-(void)KeyboardWillChangeFrame:(NSNotification *)notification
{
    // 如果正在切换键盘，就不要执行后面的代码
    if (self.switchingKeybaord) return;
    
    NSDictionary *userInfo = notification.userInfo;
    //动画持续时间
   double duration =  [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
   CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //执行动画
    [UIView animateWithDuration:duration animations:^{
        if (keyboardF.origin.y > self.view.height) {
            
            self.toolbar.y = self.view.height - self.toolbar.height;
        }else{
        
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
            
        }
        
        
    
    }];
    
 }

/**
 *  取消
 */
-(void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  发送
 */
-(void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    }else{
         [self sendWithOutImage];
    }
   

    //dismiss
    [self dismissViewControllerAnimated:YES completion:nil];

}
/**
 *  发现有图片的网络请求
 */
-(void)sendWithImage
{
    
    // URL: https://upload.api.weibo.com/2/statuses/upload.json
    
    
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	pic ture binary 微博的配图。*/
    /**	access_token true string*/
    
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HZAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    // 3.发送请求
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 *  发现没有图片的网络请求
 */
-(void)sendWithOutImage
{
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HZAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
 
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];

    
}


/**
 *  监听文字改变
 */

-(void)textDidChange
{

    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;

}


#pragma mark -- UITextViewDelegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{

    [self.view endEditing:YES];

}

#pragma mark -- HZComposeToolbarDelegate

-(void)composeToolbar:(HZComposeToolBar *)toolbar didClickButton:(HZComposeToolBarButtonType)butonnType
{
   
    switch (butonnType) {
        case HZComposeToolBarButtonTypeCamera:
            [self openCamera];
            break;
        case HZComposeToolBarButtonTypePicture:
            [self openPicture];
            break;
        case HZComposeToolBarButtonTypeMention:
             HZLog(@"----@");
            break;
        case HZComposeToolBarButtonTypeTrend:
             HZLog(@"----话题");
            break;
        case HZComposeToolBarButtonTypeEmotion:
            [self switchKeyboard];
            break;
        
    }



}


#pragma mark -- HZComposeToolbarDelegate 其他方法

-(void)switchKeyboard

{   // self.textView.inputView == nil : 使用的是系统自带的键盘
    
    if (self.textView.inputView == nil) {//键盘切换
        self.textView.inputView = self.emotionKeyboard;
        //显示键盘按钮
        self.toolbar.showKeyboardButton = YES;
    }else{//切换为系统自带的键盘
        self.textView.inputView = nil;
        //显示表情按钮
        self.toolbar.showKeyboardButton = NO;
    }

    //开始切换键盘
    self.switchingKeybaord = YES;
    
    //退出键盘
    [self.textView endEditing:YES];
    
    //结束切换键盘
    self.switchingKeybaord = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //退出键盘
        [self.textView becomeFirstResponder];
        
        
    });

}


/**
 *  打开相机
 */
-(void)openCamera
{
    [self getImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

/**
 *  选择图片
 */
-(void)openPicture
{
//   如果想自己写一个图片选择控制器 利用AssetsLibrary.framework,利用这个框架可以获得手机上所有相册图片
    
//   UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self getImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}


-(void)getImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];


}

#pragma mark -- UIImagePickerControllerDelegate

/**
 *
 *从UIImagePickerController选择图片后就调用（拍照完成后或者选择相片图片后完毕);
 *
 */

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //info中就包含了选择的图片
    //HZLog(@"%@",info);
     UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //添加图片到photosView中
    [self.photosView addPhoto:image];
    

}



@end
