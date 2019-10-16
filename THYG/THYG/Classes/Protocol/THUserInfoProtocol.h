//
//  THUserInfoProtocol.h
//  THYG
//
//  Created by C on 2019/8/20.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THUserInfoProtocol <THBaseProtocol>

- (void)uploadImageSuccess:(id)response;

- (void)uploadImageFailed:(NSDictionary *)errorInfo;

- (void)updateUserInfoSuccess:(id)response;

- (void)updateUserInfoFailed:(NSDictionary *)errorInfo;

- (void)updateAvaSuccess:(NSDictionary *)response;

- (void)updateAvaFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
