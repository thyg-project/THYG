//
//  THOrderManager.h
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THOrderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THOrderPresenter : THBasePresenter

- (void)getReturnOrder:(NSString *)state;

- (void)getCanUseOrder:(NSString *)state;

- (void)deleteOrder:(NSString *)orderId;

- (void)cancelOrder:(NSString *)orderId;

- (void)reviewOrderExpress:(NSString *)orderId;

- (void)remindNoticeOrder:(NSString *)orderId;

@end

NS_ASSUME_NONNULL_END
