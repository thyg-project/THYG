//
//  YGNetworkCommon.m
//  test
//
//  Created by C on 2018/11/23.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGNetworkCommon.h"
#import "YGEncryptTool.h"

#define kBaseUrl @"http://testw.mm94178.com/app/"

#define kRequestUrlFormat(url) [NSString stringWithFormat:@"%@%@",kBaseUrl,url]

@implementation YGNetworkCommon


+ (void)setRequestHeaderInfo:(AFHTTPSessionManager *)manager {
    [manager.requestSerializer setValue:@"" forHTTPHeaderField:@"Authentication"];
}



+ (void)login:(NSString *)userName psd:(NSString *)psd success:(SuccessBlock)success failed:(FailedBlock)failed {
    [[YGNetWorkTools sharedTools] post:@"" sessionConfig:^(AFHTTPSessionManager *manager) {
        
    } parameters:@{} success:success failed:failed];
}

+ (void)register:(NSString *)phone psd:(NSString *)psd success:(SuccessBlock)success failed:(FailedBlock)failed {
    [[YGNetWorkTools sharedTools] post:@"" sessionConfig:nil parameters:@{} success:success failed:failed];
}

+ (void)getUserInfo:(SuccessBlock)success failed:(FailedBlock)failed {
    [[YGNetWorkTools sharedTools] get:@"" sessionConfig:^(AFHTTPSessionManager *manager) {
        [self setRequestHeaderInfo:manager];
    } parameters:@{} success:success failed:failed];
}





@end
