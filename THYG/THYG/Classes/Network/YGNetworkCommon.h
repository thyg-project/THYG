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
//登录
+ (NSURLSessionTask *)login:(NSString *)userName pwd:(NSString *)pwd success:(SuccessBlock)success failed:(FailedBlock)failed;

//注册
+ (NSURLSessionTask *)registerUser:(NSString *)mobile success:(SuccessBlock)success failed:(FailedBlock)failed;

//验证码
+ (NSURLSessionTask *)sendVerifyCode:(NSString *)mobile success:(SuccessBlock)success failed:(FailedBlock)failed;

//获取用户信息
+ (NSURLSessionTask *)getUserInfo:(SuccessBlock)success failed:(FailedBlock)failed;

//我的晒单
+ (NSURLSessionTask *)getNoboxingListSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

//任务列表
+ (NSURLSessionTask *)getTaskListSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

//邀请管理
+ (NSURLSessionTask *)inviteListSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

//关注列表
+ (NSURLSessionTask *)attentionListSuccess:(SuccessBlock)success failed:(FailedBlock)failed;

@end

