//
//  THAttentionProtocol.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THMyCollectModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THAttentionProtocol <THBaseProtocol>

- (void)getAttentionDataSuccess:(NSArray <THMyCollectModel *>*)response;

- (void)getAttentionDataFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
