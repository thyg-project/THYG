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
        }
    }
#endif
}

- (void)setNavigationBarColor:(UIColor *)color {
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:color] forBarMetrics:UIBarMetricsDefault];
}

@end
