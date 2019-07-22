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
        [self performToSelector:@selector(registerSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(registerFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)sendVerifyCode:(NSString *)mobile {
    NSURLSessionTask *task = [YGNetworkCommon registerUser:mobile success:^(id responseObject) {
         [self performToSelector:@selector(sendVerifyCodeSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(sendVerifyCodeFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)getUserInfo {
    NSURLSessionTask *task = [YGNetworkCommon getUserInfo:^(id responseObject) {
         [self performToSelector:@selector(getUserInfoSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getUserInfoFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
