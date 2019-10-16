//
//  THCardProtocol.h
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THCardProtocol <THBaseProtocol>

- (void)getShoppingCardListSuccess:(NSArray *)list;

- (void)getShoppingCardListFailed:(NSDictionary *)errorInfo;

- (void)selectedAllSuccess:(NSDictionary *)info;

- (void)selectedAllFailed:(NSDictionary *)errorInfo;

- (void)deleteGoodsSuccess:(NSDictionary *)info;

- (void)deleteGoodsFailed:(NSDictionary *)errorInfo;

- (void)moveToCollectSuccess:(NSDictionary *)info;

- (void)moveToCollectFailed:(NSDictionary *)errorInfo;


- (void)changedGoodsNumberSuccess:(NSDictionary *)response;

- (void)changedGoodsNumberFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
