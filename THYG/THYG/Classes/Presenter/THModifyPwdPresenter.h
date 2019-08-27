//
//  THModifyPwdPresenter.h
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THModifyPwdProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THModifyPwdPresenter : THBasePresenter

- (void)modifyPwdOrigin:(NSString *)originPwd newPwd:(NSString *)newPwd confirmPwd:(NSString *)confirmPwd;

@end

NS_ASSUME_NONNULL_END
