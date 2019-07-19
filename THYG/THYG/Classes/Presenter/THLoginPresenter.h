//
//  THLoginPresenter.h
//  THYG
//
//  Created by C on 2019/7/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THLoginProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THLoginPresenter : THBasePresenter

- (void)loginMobile:(NSString *)mobile pwd:(NSString *)pwd;

- (void)getUserInfo;

@end

NS_ASSUME_NONNULL_END
