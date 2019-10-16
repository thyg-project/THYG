//
//  THOrderPresenter.m
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THOrderPresenter.h"

@implementation THOrderPresenter

- (void)getReturnOrder:(NSString *)state {
    NSURLSessionTask *task = [YGNetworkCommon getReturnOrder:state success:^(id responseObject) {
        [self performToSelector:@selector(getReturnOrderSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getReturnOrderFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)getCanUseOrder:(NSString *)state {
    NSURLSessionTask *task = [YGNetworkCommon getCanUseOrder:state success:^(id responseObject) {
        NSArray *list = [NSArray modelArrayWithClass:THOrderModel.class json:responseObject[@"info"][@"list"]];
        [self performToSelector:@selector(getCanUseOrderSuccess:) params:list];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getCanUseOrderFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)deleteOrder:(NSString *)orderId {
    NSURLSessionTask *task = [YGNetworkCommon deleteOrder:orderId success:^(id responseObject) {
        [self performToSelector:@selector(deleteOrderSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(deleteOrderFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)cancelOrder:(NSString *)orderId {
    NSURLSessionTask *task = [YGNetworkCommon cancelOrder:orderId success:^(id responseObject) {
        [self performToSelector:@selector(cancelOrderSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(cancelOrderFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)reviewOrderExpress:(NSString *)orderId {
    NSURLSessionTask *task = [YGNetworkCommon reviewOrderExpress:orderId success:^(id responseObject) {
        [self performToSelector:@selector(reviewOrderExpressSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(reviewOrderExpressFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)remindNoticeOrder:(NSString *)orderId {
    NSURLSessionTask *task = [YGNetworkCommon remindNoticeOrder:orderId success:^(id responseObject) {
        [self performToSelector:@selector(remindNoticeOrderSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(remindNoticeOrderFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
