//
//  THGoodsInfoProtocol.h
//  THYG
//
//  Created by C on 2019/10/15.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THGoosDetailModel.h"
#import "THGoodsSpecModel.h"
#import "THGoodsCommentModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THGoodsInfoProtocol <THBaseProtocol>

@optional
- (void)getGoodsDetailSuccess:(THGoosDetailModel *)response;
- (void)getBannerSuccess:(NSArray <THGoodsDetailBannerModel *> *)response;
- (void)getGoodsDetailFailed:(NSDictionary *)errorInfo;


- (void)getGoodsSpecSuccess:(THGoodsSpecModel *)response;
- (void)getGoodsSpecFailed:(NSDictionary *)errorInfo;

- (void)getGoodsCommentsSuccess:(NSArray <THGoodsCommentModel *> *)list;
- (void)getGoodsCommentsFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
