//
//  THRegisterPresenter.m
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THRegisterPresenter.h"
#import "YGCacheManager.h"

@implementation THRegisterPresenter

- (void)registerUser:(NSDictionary *)params {
    NSURLSessionTask *task = [YGNetworkCommon registerUser:params success:^(id responseObject) {
        THUserManager.sharedInstance.token = responseObject[@"info"][@"token"];
        [self performToSelector:@selector(registerSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(registerFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)sendVerifyCode:(NSString *)mobile type:(NSInteger)type {
    NSURLSessionTask *task = [YGNetworkCommon sendVerifyCode:mobile type:type success:^(id responseObject) {
         [self performToSelector:@selector(sendVerifyCodeSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(sendVerifyCodeFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)getUserInfo {
    NSURLSessionTask *task = [YGNetworkCommon getUserInfo:^(id responseObject) {
        THUserManager *m = [THUserManager sharedInstance];
        m.userInfo = [THUserInfoModel modelWithJSON:responseObject[@"info"]];
        [YGCacheManager.sharedInstance saveUserInfo];
        [self performToSelector:@selector(getUserInfoSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getUserInfoFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)forgetPwd:(NSDictionary *)params {
    NSURLSessionTask *task = [YGNetworkCommon forgetPwd:params success:^(id responseObject) {
         [self performToSelector:@selector(findPwdSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
         [self performToSelector:@selector(findPwdFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
