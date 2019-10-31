//
//  THHomeHeaderItemModel.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeHeaderItemModel.h"

@implementation THHomeHeaderItemModel

- (void)setName:(NSString *)name {
    _name = name;
    _image = [_name stringByAppendingString:@".png"];
}

@end
