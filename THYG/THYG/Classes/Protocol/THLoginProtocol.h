//
//  THLoginProtocol.h
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"


@protocol THLoginProtocol <THBaseProtocol>

- (void)loginSuccess:(NSDictionary *)response;

- (void)loginFailed:(NSDictionary *)errorInfo;

- (void)getUserInfoSuccess:(NSDictionary *)response;

- (void)getUserInfoFailed:(NSDictionary *)errorInfo;

@end


