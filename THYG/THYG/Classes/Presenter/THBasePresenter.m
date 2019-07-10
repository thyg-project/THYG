//
//  THBasePresenter.m
//  THYG
//
//  Created by C on 2019/7/10.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"

@implementation THBasePresenter

- (instancetype)initPresenterWithProtocol:(id<THBaseProtocol>)protocol {
    if (self = [super init]) {
        _delegate = protocol;
    }
    return self;
}

- (void)test {
   NSURLSessionTask *task = [YGNetworkCommon login:@"" psd:@"" success:^(id responseObject) {
       if ([self.delegate respondsToSelector:@selector(getDataSuccess:extra:)]) {
           [self.delegate getDataSuccess:responseObject extra:nil];
       }
    } failed:^(NSDictionary *errorInfo) {
        if ([self.delegate respondsToSelector:@selector(getDataFailed:extra:)]) {
            [self.delegate respondsToSelector:@selector(getDataFailed:extra:)];
        }
    }];
    if ([self.delegate respondsToSelector:@selector(getTask:)]) {
        [self.delegate getTask:task];
    }
}

@end
