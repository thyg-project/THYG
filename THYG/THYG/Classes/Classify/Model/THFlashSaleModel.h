//
//  THFlashSaleModel.h
//  THYG
//
//  Created by Mac on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THFlashSaleModel : NSObject

@property (nonatomic, copy) NSString *saleID;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *goodsID;
@property (nonatomic, copy) NSString *itemId;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) NSInteger goodsNum;
@property (nonatomic, copy) NSString *buyLimit;
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, assign) NSInteger orderNum;
@property (nonatomic, copy) NSString *descript;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) BOOL isEnd;
@property (nonatomic, assign) BOOL isDel;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, assign) CGFloat shopPrice;
@property (nonatomic, copy) NSString *originalImg;
@property (nonatomic, assign) CGFloat percent;

@end
