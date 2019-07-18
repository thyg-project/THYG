//
//  THUserInfoModel.m
//  THYG
//
//  Created by Colin on 2018/3/30.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUserInfoModel.h"
#import "NSObject+YYModel.h"

@implementation THUserInfoModel

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self modelEncodeWithCoder:aCoder];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [self modelInitWithCoder:aDecoder];
}



@end
