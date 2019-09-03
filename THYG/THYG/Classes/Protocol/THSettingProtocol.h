//
//  THSettingProtocol.h
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THSettingProtocol <THBaseProtocol>

- (void)logoutSuccess;

- (void)clearCacheSuccess;

@end

NS_ASSUME_NONNULL_END
