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

- (void)getTask:(NSURLSessionTask *)task {
    if (!task) {
        return;
    }
    if ([self.delegate respondsToSelector:@selector(getTask:)]) {
        [self.delegate getTask:task];
    }
}

- (void)performToSelector:(SEL)aSelecter params:(id)param {
    if ([self.delegate respondsToSelector:aSelecter]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self.delegate performSelector:aSelecter withObject:param];
#pragma clang diagnostic pop
    }
}

@end
