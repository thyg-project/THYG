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

@end
