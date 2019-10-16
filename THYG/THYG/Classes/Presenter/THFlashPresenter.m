//
//  THFlashPresenter.m
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THFlashPresenter.h"

@interface THFlashPresenter() {
    NSInteger _pageIndex;
}

@end

@implementation THFlashPresenter

- (instancetype)initPresenterWithProtocol:(id<THBaseProtocol>)protocol {
    if (self = [super initPresenterWithProtocol:protocol]) {
        _pageIndex = 0;
    }
    return self;
}

- (void)resetRefreshState {
    _pageIndex = 1;
}

- (void)loadFlashDataWithStartTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime {
    NSURLSessionTask *task = [YGNetworkCommon flashGoodsIndex:_pageIndex ++ beginTime:startTime endTime:endTime success:^(id responseObject) {
        [self performToSelector:@selector(loadFlashDataSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(loadFlashDataFailed:) params:errorInfo];
    }];
    [self getTask:task];
}



@end
