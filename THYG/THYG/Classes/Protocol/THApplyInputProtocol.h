//
//  THApplyInputProtocol.h
//  THYG
//
//  Created by C on 2019/9/2.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THApplyInputProtocol <THBaseProtocol>

- (void)applySuccess:(NSDictionary *)response;

- (void)applyFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
