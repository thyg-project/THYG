//
//  YGProvince.m
//  test
//
//  Created by C on 2018/12/10.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGProvince.h"

@implementation YGDistrict



@end

@implementation YGCity
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"arealist":[YGDistrict class]};
}


@end

@implementation YGProvince

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"citylist":[YGCity class]};
}

@end
