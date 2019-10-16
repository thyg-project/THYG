//
//  THGoodsVC.h
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
#import "THGoosDetailModel.h"
#import "THGoodsCommentModel.h"
#import "THGoodsSpecModel.h"

@protocol THGoodsDetailDelegate;

@interface THGoodsVC : THBaseVC
/** 商品详情模型*/
@property (nonatomic, strong) THGoosDetailModel *detailModel;
@property (nonatomic, strong) NSMutableArray <THGoodsCommentModel *> *commentArr;
@property (nonatomic, strong) THGoodsSpecModel *goodsSpecModel; // 商品规格模型
@property (nonatomic, copy) NSString *commentRatio; // 好评率
@property (nonatomic, copy) NSString *goods_id;
@property (nonatomic, weak) id <THGoodsDetailDelegate> delegate;
/** 回调规格*/
@property (nonatomic, copy) void (^specBlock)(NSString *itemId, NSString *count);

@end

@protocol THGoodsDetailDelegate <NSObject>

- (void)getWebContentSuccess:(NSString *)content;

@end
