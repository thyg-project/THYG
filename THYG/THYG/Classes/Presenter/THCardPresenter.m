//
//  THCardPresenter.m
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCardPresenter.h"

@implementation THCardPresenter

- (void)getShoppingCardList {
    NSURLSessionTask *task = [YGNetworkCommon getShoppingCardListSuccess:^(id responseObject) {
        [self performToSelector:@selector(getShoppingCardListSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getShoppingCardListFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)canSelectedAll:(BOOL)canSelected cardIds:(NSString *)cardIds {
    NSURLSessionTask *task = [YGNetworkCommon canSelectedAll:cardIds selected:canSelected success:^(id responseObject) {
        [self performToSelector:@selector(selectedAllSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(selectedAllFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)deleteCard:(NSString *)cardId {
    NSURLSessionTask *task = [YGNetworkCommon deleteCard:cardId success:^(id responseObject) {
        [self performToSelector:@selector(deleteGoodsSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(deleteGoodsFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)moveToCollect:(NSString *)cardId goodsId:(NSString *)goodsId {
    NSURLSessionTask *task = [YGNetworkCommon moveToCollect:cardId goodId:goodsId success:^(id responseObject) {
        [self performToSelector:@selector(moveToCollectSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(moveToCollectFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)changedGoodsNumber:(NSString *)cardId goodsNum:(NSInteger)goodsNum selcted:(BOOL)selected {
    NSURLSessionTask *task = [YGNetworkCommon changeCardNun:cardId goodNum:goodsNum selected:selected success:^(id responseObject) {
        [self performToSelector:@selector(changedGoodsNumberSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(changedGoodsNumberFailed:) params:errorInfo];
    }];
    [self getTask:task];
}


@end
