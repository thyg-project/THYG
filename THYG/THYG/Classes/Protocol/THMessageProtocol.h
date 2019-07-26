//
//  THMessageProtocol.h
//  THYG
//
//  Created by C on 2019/7/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THMessageModel.h"

@protocol THMessageProtocol <THBaseProtocol>

- (void)loadMessageSuccess:(NSArray <THMessageModel *> *)response;

- (void)loadMessageFailed:(NSDictionary *)errorInfo;

@end


