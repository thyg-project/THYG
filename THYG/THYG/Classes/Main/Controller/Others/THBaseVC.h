//
//  THBaseVC.h
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIScrollView+MJRefreshExtension.h"

@interface THBaseVC : UIViewController


- (void)isNavTitleWhite; // 导航栏标题是否为白色

- (void)isNavigationClear; // 导航栏透明

- (void)isNavigationNormal; // 导航栏不透明（普通状态下）

- (void)statusBarLightContent; // 状态栏白色

- (void)statusBarDefault;  // 状态栏默认（黑色）

@end
