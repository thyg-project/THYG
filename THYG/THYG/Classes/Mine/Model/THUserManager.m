//
//  THUserManager.m
//  THYG
//
//  Created by C on 2019/7/17.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THUserManager.h"

@implementation THUserManager

+ (instancetype)sharedInstance {
    static THUserManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[self alloc] init];
    });
    return m;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (THUserInfoModel *)userInfo {
    if (!_userInfo) {
        _userInfo = [THUserInfoModel new];
    }
    return _userInfo;
}

- (NSString *)token {
    if (!_token) {
        _token = @"";
    }
    return _token;
}

- (void)destory {
    _token = nil;
    _userInfo = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UserInfoInvidate" object:nil];
}

+ (BOOL)hasLogin {
    return YGInfo.validString(THUserManager.sharedInstance.token);
}

@end
