//
//  THWalletProtocol.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THWalletHeaderModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THWalletProtocol <THBaseProtocol>

- (void)getWalletInfoSuccess:(THWalletHeaderModel *)info;

- (void)getWalletInfoFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
