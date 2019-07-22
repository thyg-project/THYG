//
//  THOrderDetailPresenter.m
//  THYG
//
//  Created by C on 2019/7/22.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THOrderDetailPresenter.h"

@implementation THOrderDetailPresenter

- (void)getOrderInfoWithModel:(THOrderModel *)orderModel {
   NSArray <NSDictionary *> *info = @[@{@"title":@"订单信息"},@{@"title":@"订单号", @"detail":orderModel ? orderModel.order_info.order_sn : @""},@{@"title":@"支付方式", @"detail":orderModel ? orderModel.order_info.pay_name : @""},@{@"title":@"下单时间", @"detail":orderModel ? orderModel.order_info.add_time : @""},@{@"title":@"订单备注", @"detail":orderModel ? orderModel.order_info.user_note : @""}];
    [self performToSelector:@selector(getOrderCellInfoSuccess:) params:info];
}

- (void)getReceiveAddressWithModel:(THOrderModel *)model {
    NSArray <NSDictionary *> *addressInfo =  @[@{@"title":@"收货信息"},@{@"title":@"收货人", @"detail":model ? model.order_info.consignee : @""},@{@"title":@"联系方式", @"detail":model ? model.order_info.mobile : @""},@{@"title":@"收货地址", @"detail":model ? model.order_info.address : @""}];
    [self performToSelector:@selector(getAddressCellInfoSuccess:) params:addressInfo];
}



@end
