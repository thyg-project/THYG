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

+ (NSURLSessionTask *)login:(NSString *)userName pwd:(NSString *)pwd success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kLoginPath parameters:@{@"mobile":userName,@"password":pwd} success:success failed:failed];
}

+ (NSURLSessionTask *)getUserInfo:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kGetUserInfoPath parameters:@{@"token":THUserManager.sharedInstance.token} success:success failed:failed];
}

+ (NSURLSessionTask *)registerUser:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kRegisterPath parameters:parameters success:success failed:failed];
}

+ (NSURLSessionTask *)sendVerifyCode:(NSString *)mobile type:(NSInteger)type success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kSendMobileCodePath parameters:@{@"scene":type == 0 ? @"1" : @"2",@"mobile":mobile} success:success failed:failed];
}

+ (NSURLSessionTask *)getTaskListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kTaskListPath sessionConfig:nil parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)getNoboxingListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kUnboxingPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)inviteListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kInviteListPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)attentionListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kAttentionListPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)updateUserInfo:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *p =[self tokenParam];
    [p addEntriesFromDictionary:params];
    return [[YGNetWorkTools sharedTools] post:kUpdateUserInfoPath parameters:p success:success failed:failed];
}

+ (NSURLSessionTask *)uploadImage:(NSData *)imageData fileName:(NSString *)fileName success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] upload:kUploadImageDataPath fileName:fileName parameters:@{@"token":[THUserManager sharedInstance].token} data:imageData success:success failed:failed];
}

+ (NSURLSessionTask *)getCouponListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kCouponListPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)getBankListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kBankListPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)getWalletInfoSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kWalletInfoPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)signForState:(BOOL)state success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kSignPath parameters:@{@"state":@(state),@"token":[THUserManager sharedInstance].token} success:success failed:failed];
}

+ (NSURLSessionTask *)getAddressListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kAddressListPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)deleteAddress:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *d = [self tokenParam];
       [d addEntriesFromDictionary:params];
    return [[YGNetWorkTools sharedTools] post:kDeleteAddressPath parameters:d success:success failed:failed];
}

+ (NSURLSessionTask *)setDefaultAddress:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *d = [self tokenParam];
       [d addEntriesFromDictionary:params];
    return [[YGNetWorkTools sharedTools] post:kSetDefaultAddressPath parameters:d success:success failed:failed];
}

+ (NSURLSessionTask *)newAddressInfo:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *d = [self tokenParam];
    [d addEntriesFromDictionary:params];
    return [[YGNetWorkTools sharedTools] post:kAddAddressPath parameters:d success:success failed:failed];
}

+ (NSURLSessionTask *)editAddressInfo:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *d = [self tokenParam];
       [d addEntriesFromDictionary:params];
    return [[YGNetWorkTools sharedTools] post:kEditAddressPath parameters:d success:success failed:failed];
}

+ (NSURLSessionTask *)logoutSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kLogoutPath parameters:@{} success:success failed:failed];
}

+ (NSURLSessionTask *)modifyPwd:(NSString *)originPwd newPwd:(NSString *)newPwd success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *d = [self tokenParam];
    [d addEntriesFromDictionary:@{}];
    return [[YGNetWorkTools sharedTools] post:kModifyPwdPath parameters:d success:success failed:failed];
}

+ (NSURLSessionTask *)forgetPwd:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kForgetPwdPath parameters:params success:success failed:failed];
}

+ (NSURLSessionTask *)goodsFavourite:(NSInteger)pageIndex success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kFavouriteGoodsPath parameters:@{@"page":@(pageIndex)} success:success failed:failed];
}

+ (NSURLSessionTask *)flashGoodsIndex:(NSInteger)pageIndex beginTime:(NSTimeInterval)beginTime endTime:(NSTimeInterval)endTime success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kFlashSaleListPath parameters:@{@"page":@(pageIndex),@"start_time":@(beginTime),@"end_time":@(endTime)} success:success failed:failed];
}

+ (NSURLSessionTask *)getShoppingCardListSuccess:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kCartsListPath parameters:[self tokenParam] success:success failed:failed];
}

+ (NSURLSessionTask *)canSelectedAll:(NSString *)cardId selected:(BOOL)selected success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *d = [self tokenParam];
    [d addEntriesFromDictionary:@{@"card_ids":cardId,@"selected":@(selected)}];
    return [[YGNetWorkTools sharedTools] post:kCardSelectedAllPath parameters:d success:success failed:failed];
}

+ (NSURLSessionTask *)deleteCard:(NSString *)cardId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kCardDeletePath parameters:@{@"token":THUserManager.sharedInstance.token,@"card_ids":cardId} success:success failed:failed];
}

+ (NSURLSessionTask *)moveToCollect:(NSString *)cardId goodId:(NSString *)goodsId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kCardMoveToCollectPath parameters:@{@"token":THUserManager.sharedInstance.token,@"card_ids":cardId,@"goods_ids":goodsId} success:success failed:failed];
}

+ (NSURLSessionTask *)changeCardNun:(NSString *)cardId goodNum:(NSInteger)goodsNum selected:(BOOL)selected success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kCardChangeGoodsNumPath parameters:@{@"token":THUserManager.sharedInstance.token,@"card_ids":cardId,@"goods_num":@(goodsNum),@"selected":@(selected)} success:success failed:failed];
}

+ (NSURLSessionTask *)getCommentList:(NSInteger)type success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kUnboxingPath parameters:@{@"token":THUserManager.sharedInstance.token,@"type":@(type)} success:success failed:failed];
}

+ (NSURLSessionTask *)getReturnOrder:(NSString *)state success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kOrderReturnGoodsListPath parameters:@{@"token":THUserManager.sharedInstance.token,@"type":state} success:success failed:failed];
}

+ (NSURLSessionTask *)getCanUseOrder:(NSString *)state success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kOrderSalesGoodsListPath parameters:@{@"token":THUserManager.sharedInstance.token,@"type":state} success:success failed:failed];
}

+ (NSURLSessionTask *)deleteOrder:(NSString *)orderId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kDeleteOrderPath parameters:@{@"token":THUserManager.sharedInstance.token,@"order_id":orderId} success:success failed:failed];
}

+ (NSURLSessionTask *)cancelOrder:(NSString *)orderId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kCancelOrderPath parameters:@{@"token":THUserManager.sharedInstance.token,@"order_id":orderId} success:success failed:failed];
}

+ (NSURLSessionTask *)reviewOrderExpress:(NSString *)orderId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kOrderExpressPath parameters:@{@"token":THUserManager.sharedInstance.token,@"order_id":orderId} success:success failed:failed];
}

+ (NSURLSessionTask *)remindNoticeOrder:(NSString *)orderId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kOrderNoticePath parameters:@{@"token":THUserManager.sharedInstance.token,@"order_id":orderId} success:success failed:failed];
}

+ (NSURLSessionTask *)getGoodsDetail:(NSString *)goodsId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kGetGoodsDetailPath parameters:@{@"token":[THUserManager sharedInstance].token,@"goods_id":goodsId} success:success failed:failed];
}

+ (NSURLSessionTask *)getGoodsSpecInfo:(NSString *)goodsId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kGetGoodsSpecInfoPath parameters:@{@"token":[THUserManager sharedInstance].token,@"goods_id":goodsId} success:success failed:failed];
}

+ (NSURLSessionTask *)getGoodsComments:(NSString *)goodsId success:(SuccessBlock)success failed:(FailedBlock)failed {
    return [[YGNetWorkTools sharedTools] post:kGetGoodCommentListPath parameters:@{@"token":[THUserManager sharedInstance].token,@"goods_d":goodsId} success:success failed:failed];
}

+ (NSMutableDictionary *)tokenParam {
    return @{@"token":THUserManager.sharedInstance.token}.mutableCopy;
}

@end
