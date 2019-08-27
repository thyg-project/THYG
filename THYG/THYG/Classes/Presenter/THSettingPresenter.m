//
//  THSettingPresenter.m
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THSettingPresenter.h"

@implementation THSettingPresenter

- (void)logout {
    NSURLSessionTask *task = [YGNetworkCommon logoutSuccess:^(id responseObject) {
        [self performToSelector:@selector(logoutSuccess) params:nil];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(logoutSuccess) params:nil];
    }];
    [self getTask:task];
}


@end
