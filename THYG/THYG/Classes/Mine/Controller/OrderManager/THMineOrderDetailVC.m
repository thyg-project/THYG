//
//  THMineOrderDetailVC.m
//  THYG
//
//  Created by Mac on 2018/6/8.
//  Copyright © 2018 THYG. All rights reserved.
//

#import "THMineOrderDetailVC.h"
#import "THMineOrderDetailCell.h"
#import "THMineOrderCell.h"
#import "THMineOrderFooterView.h"
#import "THMineOrderDetailToolView.h"
#import "THOrderModel.h"

@interface THMineOrderDetailVC () <UITableViewDataSource, UITableViewDelegate, THMineOrderFooterViewDelegate>
@property (nonatomic, strong) THOrderModel *orderModel;
@property (nonatomic, strong) THMineOrderDetailToolView *toolView;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation THMineOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - setupUI
- (void)setupUI {
    self.navigationItem.title = @"订单详情";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self autoLayoutSizeContentView:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView registerClass:[THMineOrderDetailCell class] forCellReuseIdentifier:NSStringFromClass(THMineOrderDetailCell.class)];
    [self.tableView registerNib:[UINib nibWithNibName:@"THMineOrderCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMineOrderCell.class)];
    [self.tableView registerClass:[THMineOrderFooterView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass(THMineOrderFooterView.class)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.view addSubview:self.toolView];
    
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(49);
    }];
    
}

#pragma mark - 代理 & 数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) return 4;
    if (section == 4) return 5;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *baseCell = nil;

    if (indexPath.section != 2 ) {
        
        THMineOrderDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineOrderDetailCell.class)];
        
        if (indexPath.section < 2 ) {
            detailCell.detailType = 0;
            detailCell.dataSourceDict = indexPath.section == 0 ? @{@"title":@"订单状态：", @"detail":self.orderModel ? self.orderModel.order_info.order_status_desc : @""} : @{@"title":@"物流信息： ", @"detail":@"占位"};
            
        } else if (indexPath.section == 3) {
            detailCell.detailType = [(@[@0, @1, @1, @3][indexPath.row]) integerValue];
            detailCell.dataSourceDict = @[@{@"title":@"收货信息"},
                                          @{@"title":@"收货人", @"detail":self.orderModel ? self.orderModel.order_info.consignee : @""},
                                          @{@"title":@"联系方式", @"detail":self.orderModel ? self.orderModel.order_info.mobile : @""},
                                          @{@"title":@"收货地址", @"detail":self.orderModel ? self.orderModel.order_info.address : @""}][indexPath.row];
            
        } else {
            detailCell.detailType = [(@[@0, @4, @1, @1, @3][indexPath.row]) integerValue];
            detailCell.dataSourceDict = @[@{@"title":@"订单信息"},
                                          @{@"title":@"订单号", @"detail":self.orderModel ? self.orderModel.order_info.order_sn : @""},
                                          @{@"title":@"支付方式", @"detail":self.orderModel ? self.orderModel.order_info.pay_name : @""},
                                          @{@"title":@"下单时间", @"detail":self.orderModel ? self.orderModel.order_info.add_time : @""},
                                          @{@"title":@"订单备注", @"detail":self.orderModel ? self.orderModel.order_info.user_note : @""}][indexPath.row];
            detailCell.orderId = self.orderModel.order_info.order_sn;
        }
        
        baseCell = detailCell;
    
    } else {
        
        THMineOrderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineOrderCell.class)];
        orderCell.cellType = 1;
        if (self.orderModel) {
            orderCell.orderListModel = self.orderModel.order_info;
        }
        baseCell = orderCell;
        
    }
    
    return baseCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 2) {
        THMineOrderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(THMineOrderFooterView.class)];
        THOrderListModel *model = self.orderModel.order_info;
        footer.orderStatus = self.type? [model.status integerValue] : [THOrderListModel orderTypeWithCode:model.order_status_code];
        footer.isReturnOrExchange = self.type;
        footer.delegate = self;
        return footer;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return 130;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 3) {
        return 44;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 2) {
        return 44;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (THMineOrderDetailToolView *)toolView {
    if (!_toolView) {
        _toolView = [THMineOrderDetailToolView toolView];
    }
    return _toolView;
}

@end
