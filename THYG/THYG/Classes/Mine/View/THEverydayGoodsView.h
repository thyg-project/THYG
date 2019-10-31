//
//  THEverydayGoodsView.h
//  THYG
//
//  Created by C on 2019/10/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THFavouriteGoodsModel.h"

@protocol THEvertGoodsDelegate;
@interface THEverydayGoodsView : UIView

@property (nonatomic, strong) NSArray <THFavouriteGoodsModel *> *models;

@property (nonatomic, weak) id <THEvertGoodsDelegate>delegate;

@end


@protocol THEvertGoodsDelegate <NSObject>

- (void)moreGoods;

- (void)goodsView:(THEverydayGoodsView *)view didSelctedItem:(THFavouriteGoodsModel *)item;

@end
