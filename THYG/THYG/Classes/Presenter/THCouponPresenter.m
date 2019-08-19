//
//  THCouponPresenter.m
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCouponPresenter.h"

@implementation THCouponPresenter

- (void)getCouponList {
    NSURLSessionTask *task = [YGNetworkCommon getCouponListSuccess:^(id responseObject) {
        [self performToSelector:@selector(getCouponListSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getCouponListFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
