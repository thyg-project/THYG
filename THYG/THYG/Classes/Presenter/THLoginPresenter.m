//
//  THLoginPresenter.m
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THLoginPresenter.h"
#import "YGCacheManager.h"
@implementation THLoginPresenter

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

- (void)loginMobile:(NSString *)mobile pwd:(NSString *)pwd {
    NSURLSessionTask *task = [YGNetworkCommon login:mobile pwd:pwd success:^(id responseObject) {
        THUserManager.sharedInstance.token = responseObject[@"info"][@"token"];
        [self performToSelector:@selector(loginSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(loginFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
