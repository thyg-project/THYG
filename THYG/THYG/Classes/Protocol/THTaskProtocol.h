//
//  THTaskProtocol.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THTaskModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol THTaskProtocol <THBaseProtocol>

- (void)getTaskListSuccess:(NSArray <THTaskModel *> *)response;

- (void)getTaskListFailed:(NSDictionary *)errorInfo;

@end

NS_ASSUME_NONNULL_END