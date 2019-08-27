//
//  THModifyPwdProtocol.h
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THModifyPwdProtocol <THBaseProtocol>

- (void)modifyPwdSuccess:(NSDictionary *)response;

- (void)modifyPwdFailed:(NSDictionary *)response;

@end

NS_ASSUME_NONNULL_END
