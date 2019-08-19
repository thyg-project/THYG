//
//  THInviteProtocol.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THInviteInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THInviteProtocol <THBaseProtocol>

- (void)getInviteDataSuccess:(NSArray <THInviteInfoModel *> *)response;

- (void)getInviteDataFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END
