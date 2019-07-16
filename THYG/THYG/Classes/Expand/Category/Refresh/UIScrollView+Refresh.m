//
//  UIScrollView+Refresh.m
//  THYG
//
//  Created by C on 2019/7/16.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import <MJRefresh/MJRefresh.h>

@interface UIScrollView()

@end

@implementation UIScrollView (Refresh)

- (void)addRefreshHeaderAutoRefresh:(BOOL)autoRefresh animation:(BOOL)animation refreshBlock:(MJRefreshComponentRefreshingBlock)block {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        BLOCK(block);
    }];
    self.mj_header = header;
    if (autoRefresh) {
        [self.mj_header beginRefreshing];
    }
    if (animation) {
        [self.mj_header executeRefreshingCallback];
    }
}

- (void)addRefreshFooterAutomaticallyRefresh:(BOOL)autoRefresh refreshComplate:(MJRefreshComponentRefreshingBlock)block {
    if (autoRefresh) {
       MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            BLOCK(block);
        }];
        [footer setAutomaticallyRefresh:autoRefresh];
        footer.stateLabel.font = [UIFont systemFontOfSize:13];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
        self.mj_footer = footer;
    } else {
       MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            BLOCK(block);
        }];
        footer.stateLabel.font = [UIFont systemFontOfSize:13];
        footer.stateLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1];
        [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"这是我的底线啦～" forState:MJRefreshStateNoMoreData];
        self.mj_footer = footer;
    }
}

- (void)endRefresh {
    if (self.mj_header && self.mj_header.state != MJRefreshStateIdle) {
        [self.mj_header endRefreshing];
    }
    if (self.mj_footer && self.mj_footer.state != MJRefreshStateIdle) {
        [self.mj_footer endRefreshing];
    }
}

@end
