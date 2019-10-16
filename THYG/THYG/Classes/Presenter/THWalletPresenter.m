//
//  THWalletPresenter.m
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THWalletPresenter.h"

@implementation THWalletPresenter

- (void)getWalletInfo {
    NSURLSessionTask *task = [YGNetworkCommon getWalletInfoSuccess:^(id responseObject) {
        THWalletHeaderModel *model = [THWalletHeaderModel modelWithJSON:responseObject[@"info"][@"money"]];
        [self performToSelector:@selector(getWalletInfoSuccess:) params:model];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getWalletInfoFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
