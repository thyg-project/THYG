//
//  YGCacheManager.h
//  YaloGame
//
//  Created by C on 2018/12/7.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGCacheManager : NSObject

@property (nonatomic, strong, readonly, class) YGCacheManager *sharedInstance;

- (void)saveUserInfo;

- (void)clearUserInfo;

- (void)loadUserInfo;

@end

NS_ASSUME_NONNULL_END
