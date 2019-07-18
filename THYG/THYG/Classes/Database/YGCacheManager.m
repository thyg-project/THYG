//
//  YGCacheManager.m
//  YaloGame
//
//  Created by C on 2018/12/7.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGCacheManager.h"
#import "YYCache.h"
#import "NSObject+YYModel.h"


@interface YGCacheManager()

@property (nonatomic, strong) YYCache *cache;

@end

@implementation YGCacheManager

+ (instancetype)sharedInstance {
    static YGCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (YYCache *)cache {
    if (!_cache) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *executableFile = [infoDictionary objectForKey:(NSString *)kCFBundleExecutableKey];
        _cache = [YYCache cacheWithName:executableFile];
    }
    return _cache;
}

- (void)saveUserInfo {
    [self.cache setObject:THUserManager.sharedInstance.userInfo forKey:@"THUserInfo"];
}

- (void)clearUserInfo {
    [self.cache removeObjectForKey:@"THUserInfo"];
}

- (void)loadUserInfo {
//   NSDictionary *dict = (NSDictionary *)[self.cache objectForKey:@"THUserInfo"];
//    [YGUserInfo.defaultInstance parseToken:dict];
//    [YGUserInfo.defaultInstance parseUserInfo:dict];
}

@end
