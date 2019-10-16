//
//  THFlashPresenter.h
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THFlashProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THFlashPresenter : THBasePresenter

- (void)resetRefreshState;

- (void)loadFlashDataWithStartTime:(NSTimeInterval)startTime endTime:(NSTimeInterval)endTime;

@end

NS_ASSUME_NONNULL_END
