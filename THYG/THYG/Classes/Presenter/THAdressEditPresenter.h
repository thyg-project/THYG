//
//  THAdressEditPresenter.h
//  THYG
//
//  Created by C on 2019/8/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THAddressEditProtocol.h"
#import "THAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface THAdressEditPresenter : THBasePresenter

- (void)newAddress:(THAddressModel *)model;

- (void)editAddress:(THAddressModel *)model;


@end

NS_ASSUME_NONNULL_END
