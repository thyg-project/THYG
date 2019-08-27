//
//  THAddressEditListCell.h
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseCell.h"
@class THAddressModel;

@interface THAddressEditListCell : THBaseCell

@property (nonatomic, strong) THAddressModel *addressModel;

@property (nonatomic,copy) void(^setDefaultBlock)(THAddressModel *model);

@property (nonatomic,copy) void(^deleteAddressBlock)(THAddressModel *model);

@property (nonatomic,copy) void(^motifyAddressBlock)(THAddressModel *model);



@end

