//
//  THAddressPresenter.h
//  THYG
//
//  Created by C on 2019/8/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THAddressProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THAddressPresenter : THBasePresenter

- (void)setDefaultAddress:(THAddressModel *)model;

- (void)deleteAddress:(THAddressModel *)model;

- (void)getAddressList;

@end

NS_ASSUME_NONNULL_END
