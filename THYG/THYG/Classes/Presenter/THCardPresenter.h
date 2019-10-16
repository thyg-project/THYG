//
//  THCardPresenter.h
//  THYG
//
//  Created by C on 2019/10/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THCardProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface THCardPresenter : THBasePresenter

- (void)getShoppingCardList;

- (void)canSelectedAll:(BOOL)canSelected cardIds:(NSString *)cardIds;

- (void)deleteCard:(NSString *)cardId;

- (void)moveToCollect:(NSString *)cardId goodsId:(NSString *)goodsId;

- (void)changedGoodsNumber:(NSString *)cardId goodsNum:(NSInteger)goodsNum selcted:(BOOL)selected;

@end

NS_ASSUME_NONNULL_END
