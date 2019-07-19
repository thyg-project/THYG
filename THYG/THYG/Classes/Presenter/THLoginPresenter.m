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
        if ([self.delegate respondsToSelector:@selector(getUserInfoSuccess:)]) {
            [self.delegate performSelector:@selector(getUserInfoSuccess:) withObject:responseObject];
        }
    } failed:^(NSDictionary *errorInfo) {
        if ([self.delegate respondsToSelector:@selector(getUserInfoFailed:)]) {
            [self.delegate performSelector:@selector(getUserInfoFailed:) withObject:errorInfo];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(getTask:)]) {
        [self.delegate getTask:task];
    }
}

- (void)loginMobile:(NSString *)mobile pwd:(NSString *)pwd {
    NSURLSessionTask *task = [YGNetworkCommon login:mobile psd:pwd success:^(id responseObject) {
        if ([self.delegate respondsToSelector:@selector(loginSuccess:)]) {
            [self.delegate performSelector:@selector(loginSuccess:) withObject:responseObject];
        }
    } failed:^(NSDictionary *errorInfo) {
        if ([self.delegate respondsToSelector:@selector(loginFailed:)]) {
            [self.delegate performSelector:@selector(loginFailed:) withObject:errorInfo];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(getTask:)]) {
        [self.delegate getTask:task];
    }
}

@end
