//
//  YGAuthTool.h
//  YaloGame
//
//  Created by C on 2018/11/17.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGAuthTool : NSObject

+ (BOOL)cameraAuth;

+ (BOOL)photosAuth;

+ (void)requestPhotoAuth:(void (^)(void))confirmHandler;
@end

NS_ASSUME_NONNULL_END
