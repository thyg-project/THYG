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
        [self performToSelector:@selector(authCameraSuccess) params:nil];
    } DeniedBlock:^{
        [self performToSelector:@selector(authCameraFailed) params:nil];
    }];
   
}

@end
