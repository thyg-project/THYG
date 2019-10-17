//
//  THCatogoryModel.m
//  THYG
//
//  Created by C on 2019/10/16.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCatogoryModel.h"

@implementation THCatogoryModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"title":@"mobile_name",@"ca_id":@"id"};
}

@end
