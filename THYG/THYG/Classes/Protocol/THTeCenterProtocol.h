//
//  THTeCenterProtocol.h
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THTeHuiModel.h"

@protocol THTeCenterProtocol <THBaseProtocol>

- (void)loadTeSuccess:(NSArray <THTeHuiModel *> *)response;

- (void)loadTeFailed:(NSDictionary *)errorInfo;

@end

