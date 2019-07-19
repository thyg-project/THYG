//
//  THRegisterPresenter.m
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THRegisterPresenter.h"

@implementation THRegisterPresenter

- (void)registerUser:(NSString *)mobile verifyCode:(NSString *)code pwd:(NSString *)pwd {
    NSURLSessionTask *task = [YGNetworkCommon registerUser:mobile success:^(id responseObject) {
        if ([self.delegate respondsToSelector:@selector(registerSuccess:)]) {
            [self.delegate performSelector:@selector(registerSuccess:) withObject:responseObject];
        }
    } failed:^(NSDictionary *errorInfo) {
        if ([self.delegate respondsToSelector:@selector(registerFailed:)]) {
            [self.delegate performSelector:@selector(registerFailed:) withObject:errorInfo];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(getTask:)]) {
        [self.delegate getTask:task];
    }
}

- (void)sendVerifyCode:(NSString *)mobile {
    NSURLSessionTask *task = [YGNetworkCommon registerUser:mobile success:^(id responseObject) {
        if ([self.delegate respondsToSelector:@selector(sendVerifyCodeSuccess:)]) {
            [self.delegate performSelector:@selector(sendVerifyCodeSuccess:) withObject:responseObject];
        }
    } failed:^(NSDictionary *errorInfo) {
        if ([self.delegate respondsToSelector:@selector(sendVerifyCodeFailed:)]) {
            [self.delegate performSelector:@selector(sendVerifyCodeFailed:) withObject:errorInfo];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(getTask:)]) {
        [self.delegate getTask:task];
    }
}

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

@end
