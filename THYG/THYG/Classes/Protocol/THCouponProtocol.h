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

@end

NS_ASSUME_NONNULL_END
