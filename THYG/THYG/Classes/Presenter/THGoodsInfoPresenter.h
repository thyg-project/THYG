//
//  THGoodsInfoPresenter.h
//  THYG
//
//  Created by C on 2019/10/15.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THGoodsInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THGoodsInfoPresenter : THBasePresenter

- (void)getGoodsInfo:(NSString *)goodsId;

- (void)getGoodsSpecInfo:(NSString *)goodsInfo;

- (void)getComments:(NSString *)goodsid;

@end

NS_ASSUME_NONNULL_END
