//
//  THPay.h
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WXApi.h>
@class PayReq;
@class PayResp;

typedef void(^PayResultComplete)(id);

@interface THPay : NSObject<WXApiDelegate>

//微信支付
+ (void)weChatPay:(NSDictionary *)payReqDic success:(PayResultComplete)success failed:(PayResultComplete)failed;

//支付宝支付
+ (void)aliPay:(NSString *)orderString success:(PayResultComplete)success failed:(PayResultComplete)failed;

@end
