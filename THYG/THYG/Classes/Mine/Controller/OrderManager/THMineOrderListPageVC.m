//
//  THMineOrderListPageVC.m
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderListPageVC.h"
#import "THMineOrderCell.h"
#import "THOrderModel.h"
#import "THMineOrderFooterView.h"
#import "THMineOrderDetailVC.h"

@interface THMineOrderListPageVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THMineOrderListPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self autoLayoutSizeContentView:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
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
    
    orderCell.deleteOrderBlock = ^{
        
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

@end
