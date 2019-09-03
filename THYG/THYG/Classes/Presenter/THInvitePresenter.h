//
//  THInvitePresenter.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THInviteProtocol.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, InviteState) {
    InviteState_provider                = 0,
    InviteState_vips                    = 1,
    InviteState_recommend               = 2
};

@interface THInvitePresenter : THBasePresenter

- (void)getInviteData;

- (void)filterDataWhereState:(InviteState)inviteState fromSource:(NSArray <THInviteInfoModel *> *)source;

@end

NS_ASSUME_NONNULL_END
