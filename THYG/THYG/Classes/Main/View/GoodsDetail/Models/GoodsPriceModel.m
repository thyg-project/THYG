
//
//  GoodsPriceModel.m
//  MeiXiangDao_iOS
//
//  Created by 澜海利奥 on 2017/10/13.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import "GoodsPriceModel.h"

@implementation GoodsPriceModel

- (NSString *)minPrice {
    if (!_minPrice) {
        _minPrice = @"0.00";
    }
    return _minPrice;
}

- (NSString *)maxPrice {
    if (!_maxPrice) {
        _maxPrice = @"0.00";
    }
    return _maxPrice;
}

- (NSString *)minOriginalPrice {
    if (!_minOriginalPrice) {
        _minOriginalPrice = @"0.00";
    }
    return _minOriginalPrice;
}

- (NSString *)maxOriginalPrice {
    if (!_maxOriginalPrice) {
        _maxOriginalPrice = @"0.00";
    }
    return _maxOriginalPrice;
}

@end
