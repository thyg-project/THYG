//
//  THOrderDetailProtocol.h
//  THYG
//
//  Created by C on 2019/7/22.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"



@protocol THOrderDetailProtocol <THBaseProtocol>

- (void)getOrderCellInfoSuccess:(NSArray <NSDictionary *> *)response;

- (void)getAddressCellInfoSuccess:(NSArray <NSDictionary *> *)response;

@end


