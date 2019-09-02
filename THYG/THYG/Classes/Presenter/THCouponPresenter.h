//
//  THCouponPresenter.h
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THCouponProtocol.h"


typedef NS_ENUM(NSInteger,CouponCondition) {
    CouponCondition_All             = 0,
    CouponCondition_General         = 1,
    CouponCondition_Assign          = 2,
    CouponCondition_Other
};

@interface THCouponPresenter : THBasePresenter

- (void)getCouponList;

- (void)getCouponCenterData;

- (void)filterWhere:(CouponCondition)condition from:(NSArray *)fromSource;

@end


