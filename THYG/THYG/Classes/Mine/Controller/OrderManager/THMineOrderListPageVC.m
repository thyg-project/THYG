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
//    self.view.backgroundColor = RANDOMCOLOR;
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"THMineOrderCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMineOrderCell.class)];
    [self.tableView registerClass:[THMineOrderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass(THMineOrderFooterView.class)];
    
    [self getUserOrderList];
    
}

#pragma mark - 我的订单列表
- (void)getUserOrderList {
    
    [self.dataSource removeAllObjects];
    
//    NSString *url = self.type ? @"/Order/getReturnGoodsList" : @"/Order/getUserOrderList";
    
//    [THNetworkTool POST:API(url) parameters:@{@"token":@"", @"type":self.status} completion:^(id responseObject, NSDictionary *allResponseObject) {
//        self.dataSourceArray = [THOrderListModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"][@"list"]];
//        [self.dataTableView reloadData];
//    }];
}

#pragma mark - 删除订单
- (void)deleteOrder:(NSString *)orderId {
    [THHUD show];
//    [THNetworkTool POST:API(@"/Order/delete") parameters:@{@"token":@"", @"order_id":orderId} completion:^(id responseObject, NSDictionary *allResponseObject) {
//
//        if ([responseObject[@"code"] integerValue] == 200) {
//            [THHUD showSuccess:@"删除成功"];
//            [self getUserOrderList];
//        } else {
//            [THHUD showSuccess:responseObject[@"msg"]];
//        }
//
//    }];
}

#pragma mark - 取消订单
- (void)cancelOrder:(NSString *)orderId {
    [THHUD show];
//    [THNetworkTool POST:API(@"/Order/cancel") parameters:@{@"token":@"", @"order_id":orderId} completion:^(id responseObject, NSDictionary *allResponseObject) {
//
//        if ([responseObject[@"code"] integerValue] == 200) {
//            [THHUD showSuccess:@"取消订单成功"];
//            [self getUserOrderList];
//        } else {
//            [THHUD showSuccess:responseObject[@"msg"]];
//        }
//
//    }];
}

#pragma mark - 查看物流信息
- (void)scanExpress:(NSString *)orderId {
//    [THNetworkTool POST:API(@"/Order/express") parameters:@{@"token":@"", @"order_id":orderId} completion:^(id responseObject, NSDictionary *allResponseObject) {
//
//        [THHUD showSuccess:responseObject[@"msg"]];
//        if ([responseObject[@"code"] integerValue] == 200) {
//
//        } else {
//
//        }
//
//    }];
}

#pragma mark - 提醒发货
- (void)noticeOrder:(NSString *)orderId {
//    [THNetworkTool POST:API(@"/Order/notice") parameters:@{@"token":@"", @"order_id":orderId} completion:^(id responseObject, NSDictionary *allResponseObject) {
//
//        [THHUD showSuccess:responseObject[@"msg"]];
//        if ([responseObject[@"code"] integerValue] == 200) {
//
//        } else {
//
//        }
//
//    }];
}


#pragma mark - 数据源代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMineOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineOrderCell.class)];
    THOrderListModel *model = self.dataSource[indexPath.section];
    orderCell.orderListModel = model;
    
    orderCell.deleteOrderBlock = ^{
        [self deleteOrder:model.order_id];
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
    THMineOrderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(THMineOrderFooterView.class)];
    THOrderListModel *model = self.dataSource[section];
    footer.orderStatus = self.type? [model.status integerValue] : [THOrderListModel orderTypeWithCode:model.order_status_code];
    footer.isReturnOrExchange = self.type;
    
    footer.orderActionBlock = ^(OrderStatusType type, NSInteger tag) {
        NSLog(@"type %ld, tag %ld", type, tag);
        
        /*
        OrderStatusTypeWaitPay = 0, // 待支付
        OrderStatusTypeWaitSend,    // 待发货
        OrderStatusTypePortionSend, // 部分发货
        OrderStatusTypeWaitReceive, // 待收货
        OrderStatusTypeWaitCommit,  // 待评价
        OrderStatusTypeCancel,      // 交易取消
        OrderStatusTypeFinish,      // 交易成功
        OrderStatusTypeCancelled,   // 交易作废
         */
        
        if (self.type) {
            
            
        } else {
            
            if (type == 0) {
                if (tag == 0) {
                    [self cancelOrder:model.order_id];
                }
            }
            
            if (type == 5) {
                if (tag == 1) {
                    [self scanExpress:model.order_id];
                }
            }
            
            if (type == 1) {
                [self noticeOrder:model.order_id];
            }
            
        }
        
    };
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;//DEFAULT_TABLEVIEW_HEADER_HEAGHT;
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
