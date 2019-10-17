//
//  THGoodsDetailBottomView.h
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THGoodDetailBottomViewDelegate;

@interface THGoodsDetailBottomView : UIView

@property (nonatomic, weak) id <THGoodDetailBottomViewDelegate> delegate;

@end


@protocol THGoodDetailBottomViewDelegate <NSObject>
///@"客服"/*,@"关注"*/,@"购物车",@"加入购物车"/*,@"立即购买"*/
- (void)bottomViewDidSelectedIndex:(NSInteger)index;

@end
