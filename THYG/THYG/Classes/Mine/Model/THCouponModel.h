//
//  THCouponsModel.h
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THCouponModel : NSObject

//@property (nonatomic, copy) NSString *add_time;
//@property (nonatomic, copy) NSString *coupon_type;
//@property (nonatomic, copy) NSString *createnum;
//@property (nonatomic, copy) NSString *merchant_id;
//@property (nonatomic, copy) NSString *remark;
//@property (nonatomic, copy) NSString *send_end_time;
//@property (nonatomic, copy) NSString *send_num;
//@property (nonatomic, copy) NSString *send_start_time;
//@property (nonatomic, copy) NSString *use_num;


@property (nonatomic, copy) NSString *use_start_time;
@property (nonatomic, copy) NSString *is_del;
@property (nonatomic, copy) NSString *use_type;
@property (nonatomic, copy) NSString *condition;
@property (nonatomic, copy) NSString *money;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *use_end_time;
@property (nonatomic, copy) NSString *send_time;
@property (nonatomic, copy) NSString *use_time;
@property (nonatomic, copy) NSString *use_scope;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger uid;
@property (nonatomic, assign) NSInteger order_id;
@property (nonatomic, assign) NSInteger cid;
@property (nonatomic, assign) NSInteger get_order_id;
@property (nonatomic, assign) NSInteger code;
@end
