//
//  THRegisterPresenter.h
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THRegisterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THRegisterPresenter : THBasePresenter

- (void)registerUser:(NSString *)mobile verifyCode:(NSString *)code pwd:(NSString *)pwd;

- (void)sendVerifyCode:(NSString *)mobile;

- (void)getUserInfo;

@end

NS_ASSUME_NONNULL_END
