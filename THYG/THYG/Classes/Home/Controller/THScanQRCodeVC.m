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

@interface THScanQRCodeVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSTimer *_timer;
    UIImagePickerController *_imagePicker;
}
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) THAVCaptureSessionManager *session;

@end

@implementation THScanQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫一扫";
    [self setCropRect:CGRectMake((kScreenWidth - 256) / 2, (kScreenHeight - 256) / 2 - kNaviHeight, 256, 256)];
    [self initinalizedView];
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
                                                                   scanRect:CGRectMake((kScreenWidth - 256) / 2, (kScreenHeight - 256) / 2 - kNaviHeight, 256, 256)
                                                               successBlock:^(NSString *reuslt) {
                                                                   [self showResult:reuslt];
                                                               }];
    self.session.isPlaySound = YES;
    [self.session showPreviewLayerInView:self.view];
}

- (void)initinalizedView {
    UIButton *flashButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:flashButton];
    [flashButton setImage:[UIImage imageNamed:@"dakaishoudiantong"] forState:UIControlStateNormal];
    flashButton.imageView.contentMode = UIViewContentModeCenter;
    [flashButton setImage:[UIImage imageNamed:@"guanbishoudiantong"] forState:UIControlStateSelected];
    [flashButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-50));
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.equalTo(@(-50));
    }];
    UIButton *swButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:swButton];
    [swButton setImage:[UIImage imageNamed:@"tuiguangerweima"] forState:UIControlStateNormal];
    [swButton setImage:[UIImage imageNamed:@"tuiguangerweima"] forState:UIControlStateSelected];
    swButton.imageView.contentMode = UIViewContentModeCenter;
    [swButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(50));
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.bottom.equalTo(@(-50));
    }];
    [flashButton addTarget:self action:@selector(changeTorchState:) forControlEvents:UIControlEventTouchUpInside];
    [swButton addTarget:self action:@selector(switchScanType:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    [self.view addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@((kScreenHeight - 256) / 2 - kNaviHeight));
        make.size.mas_equalTo(CGSizeMake(256, 256));
    }];
}

- (void)setCropRect:(CGRect)cropRect{
    CAShapeLayer *cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight - kNaviHeight));
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    CGPathRelease(path);
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
    [cropLayer setNeedsDisplay];
    
    [self.view.layer addSublayer:cropLayer];
}


// 在页面将要显示的时候添加定时器
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.session start];
    [self startTimer];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

// 在页面将要消失的时候移除定时器
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.session stop];
    [self endTimer];
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)showPhotoLibary {
    [THAVCaptureSessionManager checkAuthorizationStatusForPhotoLibraryWithGrantBlock:^{
        if (!_imagePicker) {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
            imagePicker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
            imagePicker.allowsEditing = YES;
            imagePicker.delegate = self;
            _imagePicker = imagePicker;
        }
        [self presentViewController:_imagePicker animated:YES completion:nil];
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
        [self.session scanPhotoWith:[info objectForKey:@"UIImagePickerControllerOriginalImage"] successBlock:^(NSString *result) {
            [self showResult:result];
        }];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.session start];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showResult:(NSString *)result {
    if (YGInfo.validString(result) == NO) {
        UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"提示" message:@"未扫描到结果" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [view show];
        return;
    }
    if ([self.delegate respondsToSelector:@selector(scanResult:scanType:)]) {
        [self.delegate scanResult:result scanType:(self.session.captureType == AVCaptureTypeQRCode ? THScanType_QR : THScanType_Bar)];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 扫描效果
- (void)scan {
    
    
}

- (void)changeTorchState:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.session turnTorch:sender.selected];
}

- (void)startTimer {
    [self endTimer];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:30 target:self selector:@selector(scanTimeout) userInfo:nil repeats:NO];
    }
}

- (void)endTimer {
    if (_timer && [_timer isValid]) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)scanTimeout {
    [self endTimer];
    UIAlertView *view = [[UIAlertView alloc]initWithTitle:@"扫描结果" message:@"扫描超时" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [view show];
}

- (void)switchScanType:(UIButton *)sender {
    sender.selected = !sender.selected;
    if ([self.delegate respondsToSelector:@selector(share:)]) {
        [self.delegate share:self];
    }
}

@end
