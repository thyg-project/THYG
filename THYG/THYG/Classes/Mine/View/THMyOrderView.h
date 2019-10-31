//
//  THMyOrderView.h
//  THYG
//
//  Created by C on 2019/10/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, THOrderState) {
    THOrderState_All                    = 0,
    THOrderState_WaitPay                = 1,
    THOrderState_WaitReceive            = 2,
    THOrderState_WaitComment            = 3,
    THOrderState_Exchange
};

@protocol THMyOrderViewDelegate;

@interface THMyOrderView : UIView

@property (nonatomic, weak) id <THMyOrderViewDelegate> delegate;

@end


@protocol THMyOrderViewDelegate <NSObject>

- (void)orderView:(THMyOrderView *)orderView didClickState:(THOrderState)state;

@end
