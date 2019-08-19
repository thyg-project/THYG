//
//  THAttentionPresenter.m
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THAttentionPresenter.h"

@implementation THAttentionPresenter

- (void)getAttentionInfo {
    NSURLSessionTask *task = [YGNetworkCommon attentionListSuccess:^(id responseObject) {
        [self performToSelector:@selector(getAttentionDataSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getAttentionDataFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
