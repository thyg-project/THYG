//
//  THFlashProtocol.h
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THFlashProtocol <THBaseProtocol>

- (void)loadFlashDataSuccess:(NSArray *)data;

- (void)loadFlashDataFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
