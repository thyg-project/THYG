//
//  THNavigationController.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THNavigationController.h"

@interface THNavigationController () <UINavigationControllerDelegate>

@end

@implementation THNavigationController

#pragma mark - 设置UIUINavigationBar的主题
+ (void)initialize {
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:RGB(213, 0, 27)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{/*NSFontAttributeName:[UIFont systemFontOfSize:19],*/ NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 返回
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >= 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    // 跳转
    [super pushViewController:viewController animated:animated];
}

@end
