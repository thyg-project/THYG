//
//  THHomePresenter.h
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THHomeProtocol.h"

@interface THHomePresenter : THBasePresenter

- (void)checkCameraState;

- (void)goodsFavourite;

- (void)resetRefreshState;

@end

