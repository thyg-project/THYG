//
//  THScanQRCodeVC.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THScanQRCodeVC.h"
#import "THAVCaptureSessionManager.h"
#import "THButton.h"

@interface THScanQRCodeVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) THAVCaptureSessionManager *session;
@property(assign, nonatomic) BOOL TorchState;

@end

@implementation THScanQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫一扫";
    THButton *button = [[THButton alloc] initWithButtonType:THButtonType_Text];
    [button setTitle:@"相册"];
    [button setTextColor:[UIColor whiteColor]];
    [button setFont:[UIFont systemFontOfSize:16]];
    [button addTarget:self action:@selector(showPhotoLibary)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // 添加跟屏幕刷新频率一样的定时器
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(scan)];
    self.link = link;
    // 获取读取读取二维码的会话
    self.session = [[THAVCaptureSessionManager alloc]initWithAVCaptureQuality:AVCaptureQualityHigh
                                                                AVCaptureType:AVCaptureTypeQRCode
                                                                   scanRect:CGRectZero
                                                               successBlock:^(NSString *reuslt) {
                                                                   [self showResult:reuslt];
                                                               }];
    self.session.isPlaySound = YES;
    [self.session showPreviewLayerInView:self.view];
    
}

// 在页面将要显示的时候添加定时器
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session start];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 在页面将要消失的时候移除定时器
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stop];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)showPhotoLibary {
    [THAVCaptureSessionManager checkAuthorizationStatusForPhotoLibraryWithGrantBlock:^{
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
        imagePicker.delegate = self;
        [self presentViewController:imagePicker animated:YES completion:nil];
    } DeniedBlock:^{
        UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相册权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:aciton];
        [self presentViewController:controller animated:YES completion:nil];
    }];
}

#pragma mark -  imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        [self.session start];
        [self.session scanPhotoWith:[info objectForKey:@"UIImagePickerControllerOriginalImage"] successBlock:^(NSString *reuslt) {
            NSString *str = reuslt!= nil ? reuslt : @"没有识别到二维码";
            [self showResult:str];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.session start];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showResult:(NSString *)result {
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:result delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
}

// 扫描效果
- (void)scan{
    // NSLog(@"self.scanTop.constant %f",self.scanTop.constant);
    
}

- (IBAction)changeTorchState:(id)sender {
    self.TorchState = !self.TorchState;
    UIImage *image = [UIImage imageNamed:self.TorchState ? @"guanbishoudiantong" : @"dakaishoudiantong"];
    [((UIButton *)sender) setImage:image forState:UIControlStateNormal];
    [self.session turnTorch:self.TorchState];
}

@end
