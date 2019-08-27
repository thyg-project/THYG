//
//  THAddressProtocol.h
//  THYG
//
//  Created by C on 2019/8/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THAddressProtocol <THBaseProtocol>

- (void)getAddressListSuccess:(NSArray <THAddressModel *> *)response;

- (void)getAddressListFailed:(NSDictionary *)errorInfo;

- (void)deleteAddressSuccess:(NSDictionary *)response;

- (void)deleteAddressFailed:(NSDictionary *)errorInfo;

- (void)setDefaultAddressSuccess:(NSDictionary *)response;

- (void)setDefaultAddressFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
