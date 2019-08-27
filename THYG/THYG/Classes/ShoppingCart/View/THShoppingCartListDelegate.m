//
//  THShoppingCartListDelegate.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartListDelegate.h"
#import "THCartListCell.h"
#import "THCartSectionHead.h"
#import "THShoppingCartModel.h"

@interface THShoppingCartListDelegate() {
    UITableView *_mTable;
}
@end

@implementation THShoppingCartListDelegate

- (void)registerTable:(UITableView *)table {
    _mTable = table;
    [table registerNib:[UINib nibWithNibName:NSStringFromClass(THCartListCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THCartListCell.class)];
    [table registerClass:[THCartSectionHead class] forHeaderFooterViewReuseIdentifier:NSStringFromClass(THCartSectionHead.class)];
}

- (void)setData:(NSArray *)data {
    _data = data;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THCartSectionHead *head = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(THCartSectionHead.class)];
    head.contentView.backgroundColor = RGB(222, 222, 222);
    THShoppingCartModel *model = self.data[section];
    head.modelData = model.suppliers;
    head.selectBtnClick = ^{
       
    };
   
    return head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.data[section] cart] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THCartListCell"];
    THCartGoodsModel *model = [self.data[indexPath.section] cart][indexPath.row];
    cell.choosedCount = model.goods_num;
    cell.maxCount = model.goods.store_count; // 库存
    cell.modelData = model;
    cell.selectBtnClick = ^{
        
    };
	
	cell.changeGoodsNumBlock = ^{
		
	};
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
