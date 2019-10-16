//
//  THHomeProtocol.h
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THFavouriteGoodsModel.h"

@protocol THHomeProtocol <THBaseProtocol>

@optional
- (void)authCameraSuccess;

- (void)authCameraFailed;

- (void)loadFavouriteGoodsSuccess:(NSArray <THFavouriteGoodsModel *> *)list;

- (void)loadFavouriteGoodsFailed:(NSDictionary *)errorInfo;

- (void)resetDataSource;

@end

