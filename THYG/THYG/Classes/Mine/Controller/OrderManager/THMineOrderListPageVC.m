//
//  THMineOrderListPageVC.m
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderListPageVC.h"
#import "THMineOrderCell.h"
#import "THMineOrderFooterView.h"
#import "THMineOrderDetailVC.h"
#import "THOrderPresenter.h"
#import "UIScrollView+EmptyDataSet.h"

@interface THMineOrderListPageVC () <UITableViewDataSource, UITableViewDelegate, THOrderProtocol,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) THOrderPresenter *presenter;

@end

@implementation THMineOrderListPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THOrderPresenter alloc] initPresenterWithProtocol:self];
    [THHUDProgress show];
    if (self.type) {
        [self.presenter getReturnOrder:self.status];
    } else {
        [self.presenter getCanUseOrder:self.status];
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self autoLayoutSizeContentView:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.emptyDataSetSource = self;
    _tableView.emptyDataSetDelegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"THMineOrderCell" bundle:nil] forCellReuseIdentifier:@"THMineOrderCell"];
    [self.tableView registerClass:[THMineOrderFooterView class] forHeaderFooterViewReuseIdentifier:@"THMineOrderFooterView"];
}

#pragma mark - 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMineOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:@"THMineOrderCell" forIndexPath:indexPath];
    THOrderListModel *model = self.dataSource[indexPath.section];
    orderCell.orderListModel = model;
    kWeakSelf;
    orderCell.deleteOrderBlock = ^{
        kStrongSelf;
        [strongSelf.presenter deleteOrder:model.order_id];
    };
    
    return orderCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    THMineOrderDetailVC *detailVc = [[THMineOrderDetailVC alloc] init];
    THOrderListModel *om = self.dataSource[indexPath.section];
    detailVc.type = self.type;
    detailVc.orderId = om.order_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    THMineOrderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"THMineOrderFooterView"];
    THOrderListModel *model = self.dataSource[section];
    footer.orderStatus = self.type? [model.status integerValue] : [THOrderListModel orderTypeWithCode:model.order_status_code];
    footer.isReturnOrExchange = self.type;
        
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 175;
}

#pragma mark - 空数据
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"noOrder"];
}

#pragma mark --
- (void)getCanUseOrderFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getCanUseOrderSuccess:(NSArray<THOrderModel *> *)list {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray new];
    }
    [THHUDProgress dismiss];
    [_dataSource addObjectsFromArray:list];
}

- (void)getReturnOrderFailed:(NSDictionary *)errorInfo {
    
}

- (void)getReturnOrderSuccess:(NSArray *)list {
    
}

- (void)deleteOrderFailed:(NSDictionary *)errorInfo {
    
}

- (void)deleteOrderSuccess:(id)response {
    
}

- (void)cancelOrderFailed:(NSDictionary *)errorInfo {
    
}

- (void)cancelOrderSuccess:(id)response {
    
}

- (void)reviewOrderExpressFailed:(NSDictionary *)errorInfo {
    
}

- (void)reviewOrderExpressSuccess:(id)response {
    
}

- (void)remindNoticeOrderFailed:(NSDictionary *)errorInfo {
    
}

- (void)remindNoticeOrderSuccess:(id)response {
    
}

@end
