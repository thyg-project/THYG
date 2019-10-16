//
//  YGAuthTool.m
//  YaloGame
//
//  Created by C on 2018/11/17.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGAuthTool.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@implementation YGAuthTool

+ (BOOL)cameraAuth {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (BOOL)photosAuth {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

+ (void)requestPhotoAuth:(void (^)(void))confirmHandler {
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
             BLOCK(confirmHandler);
        });
    }];
}

@end
