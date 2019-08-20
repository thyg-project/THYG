//
//  YGNetworkCommon.m
//  test
//
//  Created by C on 2018/11/23.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGNetworkCommon.h"
#import "YGEncryptTool.h"
#import "THNetworkCondition.h"

@implementation YGNetworkCommon


+ (void)setRequestHeaderInfo:(AFHTTPSessionManager *)manager {
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authentication"];
}

+ (NSURLSessionTask *)login:(NSString *)userName pwd:(NSString *)pwd success:(SuccessBlock)success failed:(FailedBlock)failed {
   return [[YGNetWorkTools sharedTools] post:kLoginPath sessionConfig:^(AFHTTPSessionManager *manager) {
        
    } parameters:@{} success:success failed:failed];
}

+ (NSURLSessionTask *)getUserInfo:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kGetUserInfoPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:@{} success:success failed:failed];
}

+ (NSURLSessionTask *)registerUser:(NSString *)mobile success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kRegisterPath parameters:@{} success:success failed:failed];
}

+ (NSURLSessionTask *)sendVerifyCode:(NSString *)mobile success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kSendMobileCodePath parameters:@{} success:success failed:failed];
}

+ (NSURLSessionTask *)getTaskListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kTaskListPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

+ (NSURLSessionTask *)getNoboxingListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kUnboxingPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

+ (NSURLSessionTask *)inviteListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kInviteListPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

+ (NSURLSessionTask *)attentionListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kAttentionListPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

+ (NSURLSessionTask *)updateUserInfo:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kUpdateUserInfoPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:params success:success failed:failed];
}

+ (NSURLSessionTask *)uploadImage:(NSData *)imageData fileName:(NSString *)fileName success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] upload:kUploadImageDataPath fileName:fileName parameters:nil data:imageData success:success failed:failed];
}

+ (NSURLSessionTask *)getCouponListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kCouponListPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

+ (NSURLSessionTask *)getBankListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kBankListPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

+ (NSURLSessionTask *)getWalletInfoSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] get:kWalletInfoPath sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:nil success:success failed:failed];
}

@end
