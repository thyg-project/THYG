//
//  THGoodsInfoPresenter.m
//  THYG
//
//  Created by C on 2019/10/15.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THGoodsInfoPresenter.h"

@implementation THGoodsInfoPresenter

- (void)getGoodsInfo:(NSString *)goodsId {
    NSURLSessionTask *task = [YGNetworkCommon getGoodsDetail:goodsId success:^(id responseObject) {
        THGoosDetailModel *model = [THGoosDetailModel modelWithJSON:responseObject[@"info"][@"goods"]];
        NSArray *list = [NSArray modelArrayWithClass:THGoodsDetailBannerModel.class json:responseObject[@"info"][@"goods_images_list"]];
        model.isCollected = [responseObject[@"info"][@"collect"] boolValue];
        [self performToSelector:@selector(getGoodsDetailSuccess:) params:model];
        [self performToSelector:@selector(getBannerSuccess:) params:list];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getGoodsDetailFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)getGoodsSpecInfo:(NSString *)goodsInfo {
    NSURLSessionTask *task = [YGNetworkCommon getGoodsSpecInfo:goodsInfo success:^(id responseObject) {
        THGoodsSpecModel *model = [THGoodsSpecModel modelWithJSON:responseObject[@"info"]];
        [self performToSelector:@selector(getGoodsSpecSuccess:) params:model];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getGoodsSpecFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)getComments:(NSString *)goodsid {
    if (goodsid == nil) {
        [self performToSelector:@selector(getGoodsCommentsFailed:) params:@{@"msg":@"参数缺失"}];
        return;
    }
    NSURLSessionTask *task = [YGNetworkCommon getGoodsComments:goodsid success:^(id responseObject) {
        [self performToSelector:@selector(getGoodsCommentsSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getGoodsCommentsFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
