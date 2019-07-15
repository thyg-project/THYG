//
//  UIViewController+Tool.h
//  THYG
//
//  Created by C on 2019/7/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Tool)

- (void)autoLayoutSizeContentView:(UIScrollView *)scrollView;

- (void)setNavigationBarColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
