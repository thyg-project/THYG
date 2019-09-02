//
//  THModifyPwdPresenter.m
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THModifyPwdPresenter.h"

@implementation THModifyPwdPresenter


- (void)modifyPwdOrigin:(NSString *)originPwd newPwd:(NSString *)newPwd confirmPwd:(NSString *)confirmPwd {
    NSString *message = nil;
    BOOL validate = YES;
    if ((validate = YGInfo.validString(originPwd)) == NO) {
        message = @"原密码不能为空";
    }
    if (validate && (validate = YGInfo.validString(newPwd) == NO)) {
        message = @"新密码不能为空";
    }
    if (validate && (validate = [Utils checkPassword:newPwd]) == NO) {
        message = @"新密码格式不正确";
    }
    if (validate && (validate = YGInfo.validString(confirmPwd)) == NO) {
        message = @"确认密码不能为空";
    }
    if (validate && (validate = [newPwd isEqualToString:confirmPwd]) == NO) {
        message = @"两次密码输入不一致";
    }
    if (validate == NO) {
        [self performToSelector:@selector(modifyPwdFailed:) params:@{@"message":message}];
        return;
    }
    NSURLSessionTask *task = [YGNetworkCommon modifyPwd:originPwd newPwd:newPwd success:^(id responseObject) {
        [self performToSelector:@selector(modifyPwdSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(modifyPwdFailed:) params:errorInfo];
    }];
    [self getTask:task];
    
}

@end
