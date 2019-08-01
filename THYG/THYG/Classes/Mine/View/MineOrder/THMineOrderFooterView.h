//
//  THMineOrderFooterView.h
//  THYG
//
//  Created by Victory on 2018/6/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, OrderStatusType) {
    OrderStatusTypeWaitPay = 0, // 待支付
    OrderStatusTypeWaitSend,    // 待发货
    OrderStatusTypePortionSend, // 部分发货
    OrderStatusTypeWaitReceive, // 待收货
    OrderStatusTypeWaitCommit,  // 待评价
    OrderStatusTypeCancel,      // 交易取消
    OrderStatusTypeFinish,      // 交易成功
    OrderStatusTypeCancelled,   // 交易作废
};

@protocol THMineOrderFooterViewDelegate;

@interface THMineOrderFooterView : UITableViewHeaderFooterView

/** 订单状态*/
@property (nonatomic, assign) OrderStatusType orderStatus;

/** 是否是退换货*/
@property (nonatomic, assign) BOOL isReturnOrExchange;

@property (nonatomic, weak) id <THMineOrderFooterViewDelegate> delegate;

@end


@protocol THMineOrderFooterViewDelegate <NSObject>



@end
