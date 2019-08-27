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
+ (NSURLSessionTask *)login:(NSString *)userName
                        pwd:(NSString *)pwd
                    success:(SuccessBlock)success
                     failed:(FailedBlock)failed;

//注册
+ (NSURLSessionTask *)registerUser:(NSString *)mobile
                           success:(SuccessBlock)success
                            failed:(FailedBlock)failed;

//验证码
+ (NSURLSessionTask *)sendVerifyCode:(NSString *)mobile
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

//获取用户信息
+ (NSURLSessionTask *)getUserInfo:(SuccessBlock)success
                           failed:(FailedBlock)failed;

//我的晒单
+ (NSURLSessionTask *)getNoboxingListSuccess:(SuccessBlock)success
                                      failed:(FailedBlock)failed;

//任务列表
+ (NSURLSessionTask *)getTaskListSuccess:(SuccessBlock)success
                                  failed:(FailedBlock)failed;

//邀请管理
+ (NSURLSessionTask *)inviteListSuccess:(SuccessBlock)success
                                 failed:(FailedBlock)failed;

//关注列表
+ (NSURLSessionTask *)attentionListSuccess:(SuccessBlock)success
                                    failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getCouponListSuccess:(SuccessBlock)success
                                    failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getBankListSuccess:(SuccessBlock)success
                                  failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getWalletInfoSuccess:(SuccessBlock)success
                                    failed:(FailedBlock)failed;

+ (NSURLSessionTask *)uploadImage:(NSData *)imageData
                         fileName:(NSString *)fileName
                          success:(SuccessBlock)success
                           failed:(FailedBlock)failed;

+ (NSURLSessionTask *)updateUserInfo:(NSDictionary *)params
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

+ (NSURLSessionTask *)signForState:(BOOL)state
                           success:(SuccessBlock)success
                            failed:(FailedBlock)failed;

+ (NSURLSessionTask *)setDefaultAddress:(NSDictionary *)params
                                success:(SuccessBlock)success
                                 failed:(FailedBlock)failed;

+ (NSURLSessionTask *)deleteAddress:(NSDictionary *)params
                            success:(SuccessBlock)success
                             failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getAddressListSuccess:(SuccessBlock)success
                                     failed:(FailedBlock)failed;

+ (NSURLSessionTask *)newAddressInfo:(NSDictionary *)params
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

+ (NSURLSessionTask *)editAddressInfo:(NSDictionary *)params
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;

@end

