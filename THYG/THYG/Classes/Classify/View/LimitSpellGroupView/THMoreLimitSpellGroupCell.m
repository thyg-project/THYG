

//
//  THMoreLimitSpellGroupCell.m
//  THYG
//
//  Created by Colin on 2018/3/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMoreLimitSpellGroupCell.h"
#import "THFlashSaleModel.h"

@interface THMoreLimitSpellGroupCell() {
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *nameLbel;
    __weak IBOutlet UILabel *shopPriceLabel;
    __weak IBOutlet UILabel *priceLabel;
    __weak IBOutlet UILabel *numLabel;
    __weak IBOutlet UIProgressView *percentView;
    __weak IBOutlet UILabel *limmitLabel;
}
@end

@implementation THMoreLimitSpellGroupCell

- (void)setFlashModel:(THFlashSaleModel *)flashModel {
    _flashModel = flashModel;
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:_flashModel.originalImg] placeholderImage:[UIImage imageWithColor:kBackgroundColor]];
    nameLbel.text = _flashModel.goodsName;
    shopPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", _flashModel.shopPrice];
    priceLabel.text = [NSString stringWithFormat:@"￥%.2f", _flashModel.price];;
    numLabel.text = [NSString stringWithFormat:@"剩下%ld个", _flashModel.goodsNum];
    percentView.progress = [[@(_flashModel.percent).stringValue substringToIndex:@(_flashModel.percent).stringValue.length-1] integerValue] / 100.0;
    limmitLabel.text = [NSString stringWithFormat:@"成团数量%@个", _flashModel.buyLimit];
}

#pragma mark - 立即参团
- (IBAction)goToBuy {
    BLOCK(self.gotoBuyClick);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
