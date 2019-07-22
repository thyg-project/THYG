//
//  THLoginPresenter.m
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THLoginPresenter.h"

@implementation THLoginPresenter

- (void)getUserInfo {
    NSURLSessionTask *task = [YGNetworkCommon getUserInfo:^(id responseObject) {
        [self performToSelector:@selector(getUserInfoSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getUserInfoFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)loginMobile:(NSString *)mobile pwd:(NSString *)pwd {
    NSURLSessionTask *task = [YGNetworkCommon login:mobile psd:pwd success:^(id responseObject) {
        [self performToSelector:@selector(loginSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(loginFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
