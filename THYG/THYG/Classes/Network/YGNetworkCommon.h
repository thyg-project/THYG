//
//  YGNetworkCommon.h
//  test
//
//  Created by C on 2018/11/23.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGNetWorkTools.h"


@interface YGNetworkCommon : NSObject

+ (NSURLSessionTask *)login:(NSString *)userName psd:(NSString *)psd success:(SuccessBlock)success failed:(FailedBlock)failed;


+ (NSURLSessionTask *)registerUser:(NSString *)mobile success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (NSURLSessionTask *)sendVerifyCode:(NSString *)mobile success:(SuccessBlock)success failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getUserInfo:(SuccessBlock)success failed:(FailedBlock)failed;



@end

