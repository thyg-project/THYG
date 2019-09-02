//
//  UIViewController+Tool.m
//  THYG
//
//  Created by C on 2019/7/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "UIViewController+Tool.h"

@implementation UIViewController (Tool)


- (void)autoLayoutSizeContentView:(UIScrollView *)scrollView {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        if ([scrollView isKindOfClass:[UITableView class]]) {
            ((UITableView *)scrollView).estimatedSectionHeaderHeight = 0;
            ((UITableView *)scrollView).estimatedSectionFooterHeight = 0;
            ((UITableView *)scrollView).estimatedRowHeight = 0;
        }
    }
#endif
}

- (void)setNavigationBarColor:(UIColor *)color {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

- (void)addBackBarItem {
    if (self.fd_prefersNavigationBarHidden || self.navigationController.viewControllers.count <= 1) {
        return;
    }
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.imageInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
