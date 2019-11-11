//
//  THShoppingCartListDelegate.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartListDelegate.h"
#import "THCardTableViewCell.h"
#import "THCardSectionHeader.h"
#import "THShoppingCartModel.h"

@interface THShoppingCartListDelegate() {
    UITableView *_mTable;
}
@end

@implementation THShoppingCartListDelegate

- (void)registerTable:(UITableView *)table {
    _mTable = table;
    [table registerClass:THCardTableViewCell.class forCellReuseIdentifier:@"THCardTableViewCell"];
}

- (void)setData:(NSArray *)data {
    _data = data;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THCardSectionHeader *head = [[THCardSectionHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 38)];
    [head setSelectedBlock:^(BOOL selected){
        
    }];
    
    return head;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 16)];
    footerView.backgroundColor = kBackgroundColor;
    return footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;//self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;//[[self.data[section] cart] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 148;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THCardTableViewCell" forIndexPath:indexPath];
    [cell setChangedBlock:^(BOOL rel){
        
    }];
    [cell setShowProductDetail:^(BOOL show){
        
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
