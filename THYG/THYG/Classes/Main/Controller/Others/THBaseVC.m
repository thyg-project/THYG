//
//  THBaseVC.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
#import "THScanQRCodeVC.h"
#import "THAVCaptureSessionManager.h"

@interface THBaseVC ()
@property (nonatomic,strong) UIButton *backButton;
// 是否显示白色的状态栏
@property (nonatomic) BOOL isShowWhiteStatusBar;

@end

@implementation THBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

	// 导航栏默认是红色的
	[self isNavigationNormal];
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = BGColor;
    
    if (self.navigationController.childViewControllers.count < 1) {
        UIButton *left = [THUIFactory buttonWithImage:@"dingbu-saoyisao" selectedImage:@"dingbu-saoyisao" target:self action:@selector(scanAction)];
        left.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        left.frame = CGRectMake(0, 0, 40, 44);
        [left setTitle:@"扫一扫" forState:UIControlStateNormal];
        left.titleLabel.font = Font(9);
        [left layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
        UIButton *right = [THUIFactory buttonWithImage:@"dingbugengduo" selectedImage:@"dingbugengduo" target:self action:@selector(menuAction)];
        right.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        right.frame = CGRectMake(0, 0, 40, 44);
        [right setTitle:@"更多" forState:UIControlStateNormal];
        right.titleLabel.font = Font(9);
        [right layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
    }
    
}


#pragma mark - 导航栏按钮
- (void)scanAction {
 
    // 检查权限
    [THAVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
        THScanQRCodeVC *scanVc = [[THScanQRCodeVC alloc] init];
        [self.navigationController pushViewController:scanVc animated:YES];
    } DeniedBlock:^{
        UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相机权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:aciton];
        [self presentViewController:controller animated:YES completion:nil];
    }];
    
}


#pragma mark -- 页面加载的时候改变状态栏
- (void)viewDidLayoutSubviews {
	[super viewDidLayoutSubviews];
	if (self.isShowWhiteStatusBar) {
		[self statusBarLightContent];
	}else{
		[self statusBarDefault];
	}
}

#pragma mark -- 用于pop回来的时候改变状态栏
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	if (self.isShowWhiteStatusBar) {
		[self statusBarLightContent];
	}else{
		[self statusBarDefault];
	}
}

#pragma mark - 导航栏文字黑色
- (void)isNavTitleWhite {
	self.isShowWhiteStatusBar = NO;
	[self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:GRAY_COLOR(17),NSForegroundColorAttributeName,nil]];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    if (self.navigationController.viewControllers.count > 1) {
        [self.backButton setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
    }
	
}

#pragma mark - 导航栏透明
- (void)isNavigationClear {
	self.isShowWhiteStatusBar = YES;
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
	[self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor clearColor]]];
	[self.navigationController.navigationBar setTranslucent:YES];
	
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
	
    if (self.navigationController.viewControllers.count > 1) {
        [self.backButton setImage:[UIImage imageNamed:@"back_white"] forState:UIControlStateNormal];
    }
	
}

#pragma mark - 导航栏默认
- (void)isNavigationNormal {
    self.isShowWhiteStatusBar = YES;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
	[self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:GLOBAL_RED_COLOR] forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.translucent = NO;
}

#pragma mark - 状态栏白色
- (void)statusBarLightContent {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark - 状态栏默认黑色
- (void)statusBarDefault {
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

- (UIButton*)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, 20, 30, 44);
        [_backButton setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        _backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
        [_backButton addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setImage:[UIImage imageNamed:@"back_black"] forState:UIControlStateNormal];
        UIBarButtonItem * barButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_backButton];
        self.navigationItem.leftBarButtonItem = barButtonItem;
    }
    return _backButton;
}

- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
