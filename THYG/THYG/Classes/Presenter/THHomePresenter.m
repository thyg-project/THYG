//
//  THHomePresenter.m
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THHomePresenter.h"
#import "THHomeProtocol.h"
#import "THAVCaptureSessionManager.h"

@interface THHomePresenter() {
    NSInteger _pageIndex;
}

@end

@implementation THHomePresenter

- (instancetype)initPresenterWithProtocol:(id<THBaseProtocol>)protocol {
    if (self = [super initPresenterWithProtocol:protocol]) {
        _pageIndex = 1;
    }
    return self;
}

- (void)checkCameraState {
    [THAVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
        [self performToSelector:@selector(authCameraSuccess) params:nil];
    } DeniedBlock:^{
        [self performToSelector:@selector(authCameraFailed) params:nil];
    }];
}

- (void)resetRefreshState {
    _pageIndex = 1;
}

- (void)goodsFavourite {
    NSURLSessionTask *task = [YGNetworkCommon goodsFavourite:_pageIndex ++ success:^(id responseObject) {
        NSArray *list = [NSArray modelArrayWithClass:THFavouriteGoodsModel.class json:responseObject[@"info"]];
        if (_pageIndex == 2) {
            [self performToSelector:@selector(resetDataSource) params:nil];
        }
        [self performToSelector:@selector(loadFavouriteGoodsSuccess:) params:list];
    } failed:^(NSDictionary *errorInfo) {
        _pageIndex --;
        [self performToSelector:@selector(loadFavouriteGoodsFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
