//
//  THUserInfoPresenter.m
//  THYG
//
//  Created by C on 2019/8/20.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THUserInfoPresenter.h"

@implementation THUserInfoPresenter

- (void)uploadImage:(UIImage *)image fileName:(NSString *)fileName {
    NSData *data = UIImageJPEGRepresentation(image, 0.6);
    NSURLSessionTask *task = [YGNetworkCommon uploadImage:data fileName:fileName success:^(id responseObject) {
        [self performToSelector:@selector(uploadImageSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(uploadImageFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)updateAvatar:(NSString *)filePath {
    NSURLSessionTask *task = [YGNetworkCommon updateUserInfo:@{} success:^(id responseObject) {
        [self performToSelector:@selector(updateUserInfoSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(updateUserInfoFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
