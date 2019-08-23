//
//  THGoodsListOfCollectionLayoutCell.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsListOfCollectionLayoutCell.h"
#import "THFavouriteGoodsModel.h"

@interface THGoodsListOfCollectionLayoutCell() {
    __weak IBOutlet UIImageView *goodsImgV;
    __weak IBOutlet UILabel *goodsTitleLabel;
    __weak IBOutlet UILabel *goodsPriceLabel;
}

@end

@implementation THGoodsListOfCollectionLayoutCell

- (void)setFavModel:(THFavouriteGoodsModel *)favModel {
    _favModel = favModel;
    [goodsImgV setImageWithURL:[NSURL URLWithString:@"_favModel.original_img"] placeholder:[UIImage imageNamed:@"bimai2"]];
    goodsTitleLabel.text = _favModel.goods_name;
    goodsPriceLabel.text = [NSString stringWithFormat:@"￥%@",_favModel.shop_price];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

@end
