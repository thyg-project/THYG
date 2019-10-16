//
//  THUserInfoPresenter.h
//  THYG
//
//  Created by C on 2019/8/20.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THUserInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THUserInfoPresenter : THBasePresenter

- (void)uploadImage:(UIImage *)image fileName:(NSString *)fileName;

- (void)updateAvatar:(NSString *)filePath;



- (void)updateUserInfo:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
