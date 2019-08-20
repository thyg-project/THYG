//
//  THBankProtocol.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THBankCardModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THBankProtocol <THBaseProtocol>

- (void)getBankListSuccess:(NSArray <THBankCardModel *> *)response;

- (void)getBankListFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
