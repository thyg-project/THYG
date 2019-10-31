//
//  THMineProtocol.h
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THFavouriteGoodsModel.h"

@protocol THMineProtocol <THBaseProtocol>

- (void)getLocalDataSuccess:(NSArray <NSArray <NSString *>*>*)datas;

- (void)signSuccess:(NSDictionary *)response;

- (void)signFailed:(NSDictionary *)errorInfo;


- (void)autoLogout;


- (void)loadFavouriteGoodsSuccess:(NSArray <THFavouriteGoodsModel *> *)list;

- (void)loadFavouriteGoodsFailed:(NSDictionary *)errorInfo;

@end


