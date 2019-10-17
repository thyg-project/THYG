//
//  THApplyInputPresenter.m
//  THYG
//
//  Created by C on 2019/9/2.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THApplyInputPresenter.h"

@implementation THApplyInputPresenter

- (void)applyInfoWithAccount:(NSString *)account pwd:(NSString *)pwd confirmPwd:(NSString *)confirmPwd area:(NSString *)area name:(NSString *)name mobile:(NSString *)mobile wechatID:(NSString *)wechatID vipName:(NSString *)vipName applyID:(NSString *)applyID {
    NSString *message = nil;
    BOOL validate = YES;
    if ((validate = YGInfo.validString(account)) == NO) {
        message = @"申请的账号不能为空";
    }
    if (validate && (validate = YGInfo.validString(pwd)) == NO) {
        message = @"密码不能为空";
    }
    if (validate && (validate = [Utils checkPassword:pwd]) == NO) {
        message = @"密码格式不正确";
    }
    if (validate && (validate = YGInfo.validString(confirmPwd)) == NO) {
        message = @"确认密码不能为空";
    }
    if (validate && (validate = YGInfo.validString(area)) == NO) {
        message = @"所在地区不能为空";
    }
    if (validate && (validate = YGInfo.validString(name)) == NO) {
        message = @"姓名不能为空";
    }
    if (validate && (validate = YGInfo.validString(mobile)) == NO) {
        message = @"手机号不能为空";
    }
    if (validate && (validate = YGInfo.validString(wechatID)) == NO) {
        message = @"微信号不能为空";
    }
    if (validate && (validate = YGInfo.validString(vipName)) == NO) {
        message = @"VIP会员名不能为空";
    }
    if (validate && (validate = YGInfo.validString(applyID)) == NO) {
        message = @"申请人ID不能为空";
    }
    if (validate == NO) {
        [self performToSelector:@selector(applyFailed:) params:@{@"message":message}];
        return;
    }
    NSURLSessionTask *task = [YGNetworkCommon applySuppplier:@{} success:^(id responseObject) {
        [self performToSelector:@selector(applySuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(applyFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
