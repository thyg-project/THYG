//
//  THShoppingCartListDelegate.h
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THTableViewDelegate;

@interface THShoppingCartListDelegate : NSObject <UITableViewDelegate,UITableViewDataSource>

- (void)registerTable:(UITableView*)table;

/** 传入的数据源*/
@property (nonatomic, strong) NSArray *data;

@property (nonatomic, weak) id <THTableViewDelegate> delegate;

@end

@protocol THTableViewDelegate <NSObject>

- (void)changedGoodsNumber:(NSString *)cardId num:(NSInteger)num selected:(BOOL)selected;

- (void)singleGoodsDidSelected:(BOOL)selected;

@end
