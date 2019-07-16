//
//  UIScrollView+Refresh.h
//  THYG
//
//  Created by C on 2019/7/16.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+Refresh.h"
#import <MJRefresh/MJRefreshComponent.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView (Refresh)

- (void)addRefreshHeaderAutoRefresh:(BOOL)autoRefresh animation:(BOOL)animation refreshBlock:(MJRefreshComponentRefreshingBlock)block;

- (void)addRefreshFooterAutomaticallyRefresh:(BOOL)autoRefresh refreshComplate:(MJRefreshComponentRefreshingBlock)block;

- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
