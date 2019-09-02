//
//  THApplyInputPresenter.h
//  THYG
//
//  Created by C on 2019/9/2.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THApplyInputProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THApplyInputPresenter : THBasePresenter

- (void)applyInfoWithAccount:(NSString *)account pwd:(NSString *)pwd confirmPwd:(NSString *)confirmPwd area:(NSString *)area name:(NSString *)name mobile:(NSString *)mobile wechatID:(NSString *)wechatID vipName:(NSString *)vipName applyID:(NSString *)appID;

@end

NS_ASSUME_NONNULL_END
