//
//  THUserInfoModel.h
//  THYG
//
//  Created by Colin on 2018/3/30.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, THGender) {
    THGender_unknow         = 0,
    THGender_man            = 1,
    THGender_woman          = 2,
};

@interface THUserInfoModel : NSObject <NSCoding>


@property (nonatomic, copy) NSString *nickname;

@property (nonatomic, copy) NSString *head_pic;

@property (nonatomic, copy) NSString *level;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, copy) NSString *role;

@property (nonatomic, copy) NSString *user_money;

@property (nonatomic, copy) NSString *frozen_money;

@property (nonatomic, copy) NSString *distribut_money;

@property (nonatomic, copy) NSString *supplier_money NS_DEPRECATED_IOS(1.0.0,1.00);

@property (nonatomic, copy) NSString *invite_user_money NS_DEPRECATED_IOS(1.0.0,1.00);

@property (nonatomic, copy) NSString *pay_points;

@property (nonatomic, copy) NSString *province;

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) NSString *district;

@property (nonatomic, assign) THGender gender;

@property (nonatomic, copy) NSString *job;

@property (nonatomic, copy) NSString *favorite_cat;
@end
