//
//  THInputApplyInfoProtocol.h
//  THYG
//
//  Created by C on 2019/9/3.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THInputApplyInfoProtocol <THBaseProtocol>

- (void)inputApplyInfoSuccess:(NSDictionary *)response;

- (void)inputApplyInfoFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
