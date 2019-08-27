//
//  THAddressEditProtocol.h
//  THYG
//
//  Created by C on 2019/8/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THAddressEditProtocol <THBaseProtocol>

- (void)newAddressSuccess:(NSDictionary *)response;

- (void)newAddressFailed:(NSDictionary *)errorInfo;

- (void)eidtAddressSuccess:(NSDictionary *)response;

- (void)editAddressFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
