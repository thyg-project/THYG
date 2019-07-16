//
//  THPay.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPay.h"
#import <AlipaySDK/AlipaySDK.h>

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
@end

