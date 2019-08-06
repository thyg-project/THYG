//
//  THFlashCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THFlashCell.h"
#import "THFlashSaleModel.h"

@implementation THFlashCell {
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UILabel *nameLbel;
    __weak IBOutlet UILabel *shopPriceLabel;
    __weak IBOutlet UILabel *priceLabel;
    __weak IBOutlet UILabel *percentLabel;
    __weak IBOutlet UIProgressView *percentView;
}

- (void)setFlashModel:(THFlashSaleModel *)flashModel {
    _flashModel = flashModel;
    [imageView sd_setImageWithURL:[NSURL URLWithString:_flashModel.originalImg] placeholderImage:[UIImage imageWithColor:kBackgroundColor]];
    nameLbel.text = _flashModel.goodsName;
    shopPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",_flashModel.shopPrice];
    priceLabel.text = [NSString stringWithFormat:@"￥%.2f",_flashModel.price];
    percentLabel.text = @(_flashModel.percent).stringValue;
    percentView.progress = [[@(_flashModel.percent).stringValue substringToIndex:@(_flashModel.percent).stringValue.length-1] integerValue] / 100.0;
    
}

#pragma mark - 立即参团
- (IBAction)goToBuy {
    !self.gotoBuyClick?:self.gotoBuyClick();
}

@end

