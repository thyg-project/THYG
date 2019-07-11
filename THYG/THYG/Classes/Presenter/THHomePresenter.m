//
//  THHomePresenter.m
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THHomePresenter.h"
#import "THHomeProtocol.h"
#import "THAVCaptureSessionManager.h"

@implementation THHomePresenter

- (void)checkCameraState {
    [THAVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
        if ([self.delegate respondsToSelector:@selector(authCameraSuccess)]) {
            [(id <THHomeProtocol>)self.delegate authCameraSuccess];
        }
    } DeniedBlock:^{
        if ([self.delegate respondsToSelector:@selector(authCameraFailed)]) {
            [(id <THHomeProtocol>)self.delegate authCameraFailed];
        }
    }];
   
}

@end
