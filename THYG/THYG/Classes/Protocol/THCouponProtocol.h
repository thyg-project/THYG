//
//  THCouponProtocol.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THCouponModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THCouponProtocol <THBaseProtocol>

- (void)getCouponListSuccess:(NSArray <THCouponModel *> *)response;

- (void)getCouponListFailed:(NSDictionary *)errorInfo;

- (void)getCouponCenterSuccess:(NSArray <THCouponModel *> *)response;

- (void)getCouponCenterFailed:(NSDictionary *)errorInfo;

- (void)filterCouponResult:(NSArray <THCouponModel *> *)result;

@end

NS_ASSUME_NONNULL_END
