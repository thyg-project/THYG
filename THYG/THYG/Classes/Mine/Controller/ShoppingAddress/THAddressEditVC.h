//
//  THAddressEditVC.h
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
@class THAddressModel;
typedef NS_ENUM(NSInteger, OptionType) {
    /*新建*/
    OptionType_New          = 0,
    /*编辑*/
    OptionType_Edit
};

@protocol THEditAddressResultDelegate;

@interface THAddressEditVC : THBaseVC

@property (nonatomic,assign) OptionType optiontype;

@property (nonatomic,strong) THAddressModel *modelData;

@property (nonatomic, weak) id <THEditAddressResultDelegate> delegate;

@end

@protocol THEditAddressResultDelegate <NSObject>

- (void)updateAddress:(THAddressEditVC *)container;

- (void)newAddress:(THAddressEditVC *)container;

@end
