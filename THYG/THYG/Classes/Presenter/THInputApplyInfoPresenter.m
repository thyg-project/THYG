//
//  THInputApplyInfoPresenter.m
//  THYG
//
//  Created by C on 2019/9/3.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THInputApplyInfoPresenter.h"

@implementation THInputApplyInfoPresenter

- (void)applyInfoWithUsername:(NSString *)username identifier:(NSString *)identifier mobile:(NSString *)mobile wechatID:(NSString *)wechatID {
    NSString *message = nil;
    BOOL validate = YES;
    if ((validate = YGInfo.validString(username)) == NO) {
        message = @"姓名不能为空";
    }
    if (validate && (validate = YGInfo.validString(identifier)) == NO) {
        message = @"身份证号不能为空";
    }
    if (validate && (validate = [Utils validateIdentifierID:identifier]) == NO) {
        message = @"身份证格式不正确";
    }
    if (validate && (validate = YGInfo.validString(mobile)) == NO) {
        message = @"手机号不能为空";
    }
    if (validate && (validate = [Utils checkPhoneNum:mobile]) == NO) {
        message = @"手机号格式不正确";
    }
    if (validate && (validate = YGInfo.validString(wechatID)) == NO) {
        message = @"微信号不能为空";
    }
    if (validate == NO) {
        [self performToSelector:@selector(inputApplyInfoFailed:) params:@{@"message":message}];
        return;
    }
}

@end
