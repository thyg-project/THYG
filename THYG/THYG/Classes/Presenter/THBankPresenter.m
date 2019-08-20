//
//  THBankPresenter.m
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBankPresenter.h"

@implementation THBankPresenter

- (void)getBankList {
    NSURLSessionTask *task = [YGNetworkCommon getBankListSuccess:^(id responseObject) {
        [self performToSelector:@selector(getBankListSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getBankListFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
