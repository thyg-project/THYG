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

//优惠券列表
+ (NSURLSessionTask *)getCouponListSuccess:(SuccessBlock)success
                                    failed:(FailedBlock)failed;

//银行卡列表
+ (NSURLSessionTask *)getBankListSuccess:(SuccessBlock)success
                                  failed:(FailedBlock)failed;

//卡包信息
+ (NSURLSessionTask *)getWalletInfoSuccess:(SuccessBlock)success
                                    failed:(FailedBlock)failed;

//上传图片
+ (NSURLSessionTask *)uploadImage:(NSData *)imageData
                         fileName:(NSString *)fileName
                          success:(SuccessBlock)success
                           failed:(FailedBlock)failed;

//更新用户信息
+ (NSURLSessionTask *)updateUserInfo:(NSDictionary *)params
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

//签到
+ (NSURLSessionTask *)signForState:(BOOL)state
                           success:(SuccessBlock)success
                            failed:(FailedBlock)failed;

//设置默认地址
+ (NSURLSessionTask *)setDefaultAddress:(NSDictionary *)params
                                success:(SuccessBlock)success
                                 failed:(FailedBlock)failed;

//删除地址
+ (NSURLSessionTask *)deleteAddress:(NSDictionary *)params
                            success:(SuccessBlock)success
                             failed:(FailedBlock)failed;

//获取地址列表
+ (NSURLSessionTask *)getAddressListSuccess:(SuccessBlock)success
                                     failed:(FailedBlock)failed;

//添加地址
+ (NSURLSessionTask *)newAddressInfo:(NSDictionary *)params
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

//编辑地址
+ (NSURLSessionTask *)editAddressInfo:(NSDictionary *)params
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;

//退出登录
+ (NSURLSessionTask *)logoutSuccess:(SuccessBlock)success
                             failed:(FailedBlock)failed;

//修改密码
+ (NSURLSessionTask *)modifyPwd:(NSString *)originPwd
                         newPwd:(NSString *)newPwd
                        success:(SuccessBlock)success
                         failed:(FailedBlock)failed;

@end

