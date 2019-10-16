//
//  THCartListCell.h
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@class THCartGoodsModel;
@interface THCartListCell : UITableViewCell

@property (nonatomic, strong) THCartGoodsModel *modelData;

//最大的库存数
@property (nonatomic,assign) NSInteger maxCount;

//最后一次选择的数量
@property (nonatomic,assign) NSInteger choosedCount;

@property (nonatomic, copy) void(^selectBtnClick)(BOOL selected);
///NSDictionary *dict = @{@"token":@"", @"cart_id":carId, @"goods_num": @(goodsNum), @"selected":@(selected)};
// 加减数量回调
@property (nonatomic, copy) void(^changeGoodsNumBlock)(NSString *cardId, NSInteger goodsNum, BOOL selcted);

@end
