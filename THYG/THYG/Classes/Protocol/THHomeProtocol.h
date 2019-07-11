//
//  THHomeProtocol.h
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"


@protocol THHomeProtocol <THBaseProtocol>

@optional
- (void)authCameraSuccess;

- (void)authCameraFailed;

@end

