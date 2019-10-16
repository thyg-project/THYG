//
//  THHUDProgress.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHUDProgress.h"
#import "SVProgressHUD.h"
#import "MBProgressHUD.h"

@implementation THHUDProgress

+ (void)load {
    [self config];
}

+ (void)config {
    //设置属性
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
    [SVProgressHUD setBackgroundColor:RGBA(0,0,0, 0.7)];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setMaximumDismissTimeInterval:4];
//    [SVProgressHUD setInfoImage:[UIImage imageNamed:@"infoIcon"]];
//    [SVProgressHUD setSuccessImage:[UIImage imageNamed:@"successIcon"]];
//    [SVProgressHUD setErrorImage:[UIImage imageNamed:@"errorIcon"]];
    
    
    
    
}

+ (void)showSuccess:(NSString *)msg {
    [SVProgressHUD showSuccessWithStatus:msg];
}

+ (void)showError:(NSString *)msg {
    [SVProgressHUD showErrorWithStatus:msg];
}

+ (void)showMsg:(NSString *)msg {
    [SVProgressHUD showInfoWithStatus:msg];
}

+ (void)showProgress:(CGFloat)progress msg:(NSString *)msg {
    [SVProgressHUD showProgress:progress status:msg];
}

+ (void)showImage:(UIImage *)image msg:(NSString *)msg {
    [SVProgressHUD showImage:image status:msg];
}

+ (void)show {
    [SVProgressHUD show];
}

+ (void)show:(NSString *)msg {
    [SVProgressHUD showWithStatus:msg];
}

+ (void)dismiss {
    [SVProgressHUD dismiss];
}

+ (void)showMessage:(NSString *)message {
    [self dismiss];
    if (!YGInfo.validString(message)) {
        return;
    }
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    [MBProgressHUD hideHUDForView:window animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.label.numberOfLines = 0;
    hud.mode                      = MBProgressHUDModeText;
    hud.label.text                = message;
    hud.animationType             = MBProgressHUDAnimationZoom;
    hud.userInteractionEnabled    = NO;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}


@end
