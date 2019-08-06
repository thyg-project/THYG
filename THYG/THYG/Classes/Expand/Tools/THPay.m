//
//  THPay.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPay.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WXApi.h>
#import <UMShare/UMSocialManager.h>

@interface THPay()

@end

@implementation THPay

PayResultComplete paySuccess;
PayResultComplete payFailed;

+ (void)weChatPay:(NSDictionary *)payReqDic success:(PayResultComplete)success failed:(PayResultComplete)failed {
    paySuccess = success;
    payFailed = failed;
    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = payReqDic[@"appid"];
    req.partnerId           = payReqDic[@"partnerid"];
    req.prepayId            = payReqDic[@"prepayid"];
    req.nonceStr            = payReqDic[@"noncestr"];
    req.timeStamp           = (UInt32)[NSDate new].timeIntervalSince1970;
    req.package             = @"Sign=WXPay";
    req.sign                = payReqDic[@"sign"];
    [WXApi sendReq:req];
}

+ (void)aliPay:(NSString *)orderString success:(PayResultComplete)success failed:(PayResultComplete)failed {
    [[AlipaySDK defaultService] payOrder:orderString fromScheme:@"THAliPay" callback:^(NSDictionary *resultDic) {
        NSString *message = nil;
        switch ([resultDic[@"resultStatus"] integerValue]) {
            case 9000:
                BLOCK(success, resultDic);
                break;
            case 8000:
                BLOCK(failed,resultDic);
                message = @"正在处理中，支付结果未知";
                break;
            case 4000:
                 BLOCK(failed,resultDic);
                 message = @"支付失败";
                break;
            case 5000:
                 BLOCK(failed,resultDic);
                 message = @"重复请求";
                break;
            case 6001:
                 BLOCK(failed,resultDic);
                 message = @"取消支付";
                break;
            case 6002:
                 BLOCK(failed,resultDic);
                 message = @"网络连接出错";
                break;
            case 6004:
                 BLOCK(failed,resultDic);
                 message = @"支付结果未知";
                break;
            default:
                break;
        }
        if (YGInfo.validString(message)) {
            [THHUDProgress showError:message];
        }
        NSLog(@"reslut = %@",resultDic);
    }];
}

+ (void)onResp:(BaseResp *)resp {
    PayResp*response=(PayResp*)resp;
    switch (resp.errCode){
        case WXSuccess:
            BLOCK(paySuccess,response);
            break;
        case WXErrCodeUserCancel:
            BLOCK(payFailed,response);
            [THHUDProgress showMsg:@"取消支付"];
            break;
        default:
            BLOCK(payFailed,response);
            [THHUDProgress showError:@"支付失败"];
            break;
    }
}

+ (BOOL)th_application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if ([url.host isEqual:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:(id)[THPay class]];
    } else if ([url.host isEqualToString:@"safepay"]){
        //支付宝支付
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    } else {
        return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    }
}


@end

