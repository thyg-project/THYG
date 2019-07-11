//
//  THMineProtocol.h
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"

@protocol THMineProtocol <THBaseProtocol>

- (void)getLocalDataSuccess:(NSArray <NSArray <NSString *>*>*)datas;

@end


