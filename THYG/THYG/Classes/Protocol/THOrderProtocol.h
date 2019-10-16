//
//  THOrderProtocol.h
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THOrderModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THOrderProtocol <THBaseProtocol>

- (void)getReturnOrderSuccess:(NSArray *)list;
- (void)getReturnOrderFailed:(NSDictionary *)errorInfo;


- (void)getCanUseOrderSuccess:(NSArray <THOrderModel *>*)list;
- (void)getCanUseOrderFailed:(NSDictionary *)errorInfo;


- (void)deleteOrderSuccess:(id)response;
- (void)deleteOrderFailed:(NSDictionary *)errorInfo;

- (void)cancelOrderSuccess:(id)response;
- (void)cancelOrderFailed:(NSDictionary *)errorInfo;


- (void)reviewOrderExpressSuccess:(id)response;
- (void)reviewOrderExpressFailed:(NSDictionary *)errorInfo;

- (void)remindNoticeOrderSuccess:(id)response;
- (void)remindNoticeOrderFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
