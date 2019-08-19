//
//  THInvitePresenter.m
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THInvitePresenter.h"

@implementation THInvitePresenter

- (void)getInviteData {
    NSURLSessionTask *task = [YGNetworkCommon inviteListSuccess:^(id responseObject) {
        [self performToSelector:@selector(getInviteDataSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getInviteDataFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
