//
//  THTeCenterPresenter.m
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTeCenterPresenter.h"

@implementation THTeCenterPresenter

- (void)getTeData:(NSInteger)type {
    NSURLSessionTask *task = [YGNetworkCommon getCommentList:type success:^(id responseObject) {
        NSArray *list = [NSArray modelArrayWithClass:[THTeHuiModel class] json:responseObject[@"info"]];
        [self performToSelector:@selector(loadTeSuccess:) params:list];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(loadTeFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
