//
//  THAdressEditPresenter.m
//  THYG
//
//  Created by C on 2019/8/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THAdressEditPresenter.h"

@implementation THAdressEditPresenter

- (void)newAddress:(THAddressModel *)model {
    NSURLSessionTask *task = [YGNetworkCommon newAddressInfo:@{} success:^(id responseObject) {
        [self performToSelector:@selector(newAddressSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(newAddressFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)editAddress:(THAddressModel *)model {
    NSURLSessionTask *task = [YGNetworkCommon editAddressInfo:@{} success:^(id responseObject) {
        [self performToSelector:@selector(eidtAddressSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(editAddressFailed) params:errorInfo];
    }];
    [self getTask:task];
}

@end
