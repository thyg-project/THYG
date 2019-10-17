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
+ (NSURLSessionTask *)registerUser:(NSDictionary *)parameters
                           success:(SuccessBlock)success
                            failed:(FailedBlock)failed;

//验证码
+ (NSURLSessionTask *)sendVerifyCode:(NSString *)mobile
                                type:(NSInteger)type
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

+ (NSURLSessionTask *)forgetPwd:(NSDictionary *)params
                        success:(SuccessBlock)success
                         failed:(FailedBlock)failed;

///猜你喜欢
+ (NSURLSessionTask *)goodsFavourite:(NSInteger)pageIndex
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

///秒杀
+ (NSURLSessionTask *)flashGoodsIndex:(NSInteger)pageIndex
                            beginTime:(NSTimeInterval)beginTime
                              endTime:(NSTimeInterval)endTime
                              success:(SuccessBlock)success
                               failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getShoppingCardListSuccess:(SuccessBlock)success
                                          failed:(FailedBlock)failed;

+ (NSURLSessionTask *)canSelectedAll:(NSString *)cardId
                            selected:(BOOL)selected
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

+ (NSURLSessionTask *)deleteCard:(NSString *)cardId
                         success:(SuccessBlock)success
                          failed:(FailedBlock)failed;


+ (NSURLSessionTask *)moveToCollect:(NSString *)cardId
                             goodId:(NSString *)goodsId
                            success:(SuccessBlock)success
                             failed:(FailedBlock)failed;

+ (NSURLSessionTask *)changeCardNun:(NSString *)cardId
                            goodNum:(NSInteger)goodsNum
                           selected:(BOOL)selected
                            success:(SuccessBlock)success
                             failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getCommentList:(NSInteger)type
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

+ (NSURLSessionTask *)deleteOrder:(NSString *)orderId
                          success:(SuccessBlock)success
                           failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getReturnOrder:(NSString *)state
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

+ (NSURLSessionTask *)getCanUseOrder:(NSString *)state
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;

+ (NSURLSessionTask *)cancelOrder:(NSString *)orderId
                          success:(SuccessBlock)success
                           failed:(FailedBlock)failed;

+ (NSURLSessionTask *)reviewOrderExpress:(NSString *)orderId
                                 success:(SuccessBlock)success
                                  failed:(FailedBlock)failed;

+ (NSURLSessionTask *)remindNoticeOrder:(NSString *)orderId
                                success:(SuccessBlock)success
                                 failed:(FailedBlock)failed;
///商品规格
+ (NSURLSessionTask *)getGoodsSpecInfo:(NSString *)goodsId
                               success:(SuccessBlock)success
                                failed:(FailedBlock)failed;
///商品详情
+ (NSURLSessionTask *)getGoodsDetail:(NSString *)goodsId
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;
//商品评论
+ (NSURLSessionTask *)getGoodsComments:(NSString *)goodsId
                               success:(SuccessBlock)success
                                failed:(FailedBlock)failed;
///申请成为供应上
+ (NSURLSessionTask *)applyPromotionSpecialist:(NSDictionary *)param
                                       success:(SuccessBlock)success
                                        failed:(FailedBlock)failed;
///申请成为专员
+ (NSURLSessionTask *)applySuppplier:(NSDictionary *)param
                             success:(SuccessBlock)success
                              failed:(FailedBlock)failed;
///搜索
+ (NSURLSessionTask *)searchWithKeyWord:(NSString *)keywords
                                success:(SuccessBlock)success
                                 failed:(FailedBlock)failed;
///商品类别
+ (NSURLSessionTask *)goodsCategory:(SuccessBlock)success
                             failed:(FailedBlock)failed;


+ (NSURLSessionTask *)addCard:(NSDictionary *)params
                      success:(SuccessBlock)success
                       failed:(FailedBlock)failed;

@end

