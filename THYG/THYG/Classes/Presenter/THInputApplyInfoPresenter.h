//
//  THInputApplyInfoPresenter.h
//  THYG
//
//  Created by C on 2019/9/3.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THInputApplyInfoProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THInputApplyInfoPresenter : THBasePresenter

- (void)applyInfoWithUsername:(NSString *)username identifier:(NSString *)identifier mobile:(NSString *)mobile wechatID:(NSString *)wechatID;

@end

NS_ASSUME_NONNULL_END
