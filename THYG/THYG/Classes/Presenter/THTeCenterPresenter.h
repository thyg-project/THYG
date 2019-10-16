//
//  THTeCenterPresenter.h
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THTeCenterProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THTeCenterPresenter : THBasePresenter

- (void)getTeData:(NSInteger)type;

@end

NS_ASSUME_NONNULL_END
