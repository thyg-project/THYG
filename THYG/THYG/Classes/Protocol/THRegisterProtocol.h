//
//  THRegisterProtocol.h
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THRegisterProtocol <THBaseProtocol>

@optional

- (void)registerSuccess:(NSDictionary *)response;

- (void)registerFailed:(NSDictionary *)errorInfo;

- (void)sendVerifyCodeSuccess:(NSDictionary *)response;

- (void)sendVerifyCodeFailed:(NSDictionary *)errorInfo;

- (void)getUserInfoSuccess:(NSDictionary *)response;

- (void)getUserInfoFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
