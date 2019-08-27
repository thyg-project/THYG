//
//  THAddressPresenter.m
//  THYG
//
//  Created by C on 2019/8/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THAddressPresenter.h"

@implementation THAddressPresenter

- (void)getAddressList {
    NSURLSessionTask *task = [YGNetworkCommon getAddressListSuccess:^(id responseObject) {
        [self performToSelector:@selector(getAddressListSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getAddressListFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)setDefaultAddress:(THAddressModel *)model {
    NSURLSessionTask *task = [YGNetworkCommon setDefaultAddress:@{} success:^(id responseObject) {
        if ([self.delegate respondsToSelector:@selector(setDefaultAddressSuccess:address:)]) {
            [(id <THAddressProtocol>)self.delegate setDefaultAddressSuccess:responseObject address:model];
        }
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(setDefaultAddressFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)deleteAddress:(THAddressModel *)model {
    NSURLSessionTask *task = [YGNetworkCommon deleteAddress:@{} success:^(id responseObject) {
        if ([self.delegate respondsToSelector:@selector(deleteAddressSuccess:address:)]) {
            [(id <THAddressProtocol>)self.delegate deleteAddressSuccess:responseObject address:model];
        }
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(deleteAddressFailed:) params:errorInfo];
    }];
    [self getTask:task];
}


@end
