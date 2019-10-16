//
//  THGoodsSpecModel.m
//  THYG
//
//  Created by Mac on 2018/4/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsSpecModel.h"

@implementation THGoodsSpecModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"default":THSpecDefaultModel.class,
             @"filter_spec":THFilterSpecModel.class,
             @"spec_goods_price":THSpecDefaultModel.class
    };
}
@end


@implementation THFilterSpecModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"spec":[THItemSpecModel class]};
}

@end


@implementation THSpecDefaultModel

@end

@implementation THItemSpecModel

@end


