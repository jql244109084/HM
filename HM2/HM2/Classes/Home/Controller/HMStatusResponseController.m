//
//  HMStatusResponseController.m
//  HM2
//
//  Created by 焦起龙 on 17/1/8.
//  Copyright © 2017年 JqlLove. All rights reserved.
//

#import "HMStatusResponseController.h"
#import "HMAccountTool.h"
#import "HMStatusTextView.h"
#import "HMResponseToolbar.h"
#import "HMPhotosView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "HMEmotionView.h"

@interface HMStatusResponseController ()<UITextViewDelegate,HMResponseToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,weak) HMStatusTextView *textView;
@property (nonatomic,weak) HMResponseToolbar *toolbar;
@property (nonatomic,weak) HMPhotosView *photosView;
@property (nonatomic,assign) BOOL switchKeyBoard;
@property (nonatomic,strong) HMEmotionView *emotionKeyboard;
@end

@implementation HMStatusResponseController

- (HMEmotionView *)emotionKeyboard {
    if (_emotionKeyboard == nil) {
        _emotionKeyboard = [[HMEmotionView alloc] init];
        _emotionKeyboard.width = self.view.width;
        _emotionKeyboard.height = 253;

    }
    return _emotionKeyboard;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNav];
    [self setupTextView];
    [self setToolbar];
    [self setPhotosView];

}
- (void)setPhotosView {
    HMPhotosView *photoView = [[HMPhotosView alloc] init];
    photoView.x = 0;
    photoView.y = 70;
    photoView.width = self.view.width;
    photoView.height = self.view.height;
    photoView.backgroundColor = HMRandomColor;
    [self.textView addSubview:photoView];
    self.photosView = photoView;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];
}
- (void)responseToolbar:(HMResponseToolbar *)toolbar didClickedButtonType:(NSUInteger)buttonType {
    switch (buttonType) {
        case HMToolbarButtonTypeCanmera:
            NSLog(@"HMToolbarButtonTypeCanmera");
            [self openCanmera];
            break;
        case HMToolbarButtonTypePicture:
            NSLog(@"HMToolbarButtonTypePicture");
            [self openPictureLibray];
            
            break;
        case HMToolbarButtonTypeMention:
            NSLog(@"HMToolbarButtonTypeMention");
            
            break;
        case HMToolbarButtonTypeTrend:
            NSLog(@"HMToolbarButtonTypeTrend");
            
            break;
        case HMToolbarButtonTypeEmotion:
            [self switchkeyboard];
            break;
            
        default:
            break;
    }
}

//切换键盘
- (void)switchkeyboard {
    self.switchKeyBoard = YES;
    if (self.textView.inputView == nil) {
        self.textView.inputView = self.emotionKeyboard;
        self.toolbar.showKeyboard = NO;
        
    }else {
        self.textView.inputView = nil;
        self.toolbar.showKeyboard = YES;

    }
    [self.textView resignFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.textView becomeFirstResponder];
        self.switchKeyBoard = NO;
    });
}
- (void)openCanmera {
    
}
- (void)openPictureLibray {
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = type;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"--%@",info);
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.photosView addImage:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)setToolbar {
    HMResponseToolbar *toolbar = [[HMResponseToolbar alloc] init];
    toolbar.delegate = self;
    toolbar.height = 44;
    toolbar.width = self.view.width;
    toolbar.x = 0;
    toolbar.y = self.view.height - toolbar.height;
    [self.view addSubview:toolbar];
    self.toolbar = toolbar;
    
}
- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    
    if (self.switchKeyBoard) return;
    
    NSDictionary *notifi = notification.userInfo;
    double duration = [notifi[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardF = [notifi[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardF.origin.y > self.view.height) { // 键盘的Y值已经远远超过了控制器view的高度
            self.toolbar.y = self.view.height - self.toolbar.height;
        } else {
            self.toolbar.y = keyboardF.origin.y - self.toolbar.height;
        }

    }];

}
- (void)setupTextView {
    HMStatusTextView *textView = [[HMStatusTextView alloc] init];
    textView.frame = self.view.bounds;
    textView.pleacehoder = @"请分享新鲜事...";
    textView.color = [UIColor grayColor];
    textView.delegate = self;
    textView.alwaysBounceVertical = YES;
    [self.view addSubview:textView];
    self.textView = textView;
    
    [HMNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    //添加通知
    [HMNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)textDidChange {
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}
- (void)dealloc {
    [HMNotificationCenter removeObserver:self];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.textView endEditing:YES];
}
- (void)setupNav {
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStylePlain target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    NSString *name = [HMAccountTool account].name;
    UILabel *titleView = [[UILabel alloc] init];
    titleView.textAlignment = NSTextAlignmentCenter;
    titleView.width = 200;
    titleView.height = 35;
    titleView.text = name;
    titleView.numberOfLines = 0;
    self.navigationItem.titleView = titleView;
    
    //设置字体
    NSString *string = [NSString stringWithFormat:@"发微博\n%@",name];
    NSMutableAttributedString *attsString = [[NSMutableAttributedString alloc] initWithString:string];
    [attsString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[string rangeOfString:name]];
    [attsString addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:[string rangeOfString:name]];
    titleView.attributedText = attsString;
    
}
-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)send {
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)sendWithoutImage {
    
    // URL: https://api.weibo.com/2/statuses/update.json
    // 参数:
    /**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
    /**	access_token true string*/
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HMAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    // 3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}
- (void)sendWithImage {
    
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [HMAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        [formData appendPartWithFileData:data name:@"pic" fileName:@"照片" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [MBProgressHUD showSuccess:@"发送失败"];
    }];

}





























@end
