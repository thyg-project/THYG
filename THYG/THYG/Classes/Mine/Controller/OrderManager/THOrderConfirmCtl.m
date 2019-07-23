//
//  THOrderConfirmCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/4/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THOrderConfirmCtl.h"
#import "THAddressCell.h"
#import "THBuyGoodsCell.h"
#import "THLogisticsCell.h"
#import "THOrderConfirmListCell.h"
#import "THAddressVC.h"
#import "THAddressModel.h"
#import "THCartDetailModel.h"
#import "THCouponsModel.h"
#import "THOrderCouponModel.h"
#import "THUseCouponCtl.h"
#import "THPayMethodCtl.h"

@interface THOrderConfirmCtl ()<UITableViewDelegate,UITableViewDataSource> {
    NSArray *_leftValues;
    NSArray *_rightValues;
}
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic, strong) NSArray *addressList;
@property (weak, nonatomic) IBOutlet UILabel *paytotalMoneyLabel;
@property (nonatomic, strong) THCartDetailModel *modelData;
@property (nonatomic, copy) NSString *invoiceNameParma;//发票抬头名称
@property (nonatomic, strong) THCouponsModel *couponsModel;
@property (nonatomic, strong) THAddressModel *selectAddressModel;//当前选择的地址
@property (nonatomic, strong) THOrderCouponModel *orderCouponModel;
@property (nonatomic, assign) NSInteger sectionCount;
@end

@implementation THOrderConfirmCtl

- (instancetype)init {
    self = [super init];
    if (self) {
        self.invoiceNameParma = @"未开发票";
        self.couponsModel = [[THCouponsModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _sectionCount = 7;
    _leftValues = @[@[@"发票",self.invoiceNameParma],@[@"使用优惠券",self.couponsModel.name.length?self.couponsModel.name:@"暂无优惠券可用"],@[@"备注"],@[@"商品金额",@"运费"]];
    _rightValues = @[@[@"未开发票",@""],@[[NSString stringWithFormat:@"%ld张可用",self.modelData.userCartCouponList.count],@""],@[@""],@[[NSString stringWithFormat:@"￥%.2lf",self.orderCouponModel.goodsFee],[NSString stringWithFormat:@"￥%.2lf",self.orderCouponModel.postFee]]];
    
    
    // iOS11 适配
    [self autoLayoutSizeContentView:self.mTable];
    [self.view addSubview:self.mTable];
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(-50);
    }];
    
}

#pragma mark -- 提交订单
- (IBAction)submitOrderAction:(id)sender {
    if (_sectionCount == 7) {
        
    } else {
        [THHUDProgress showMsg:@"请先填写收货地址"];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_sectionCount == 7) {
        
        if (section == 0 || section == 2 || section == 5) {
            return 1;
        } else if (section == 1) {
            return self.modelData.cartGoodsList.count;
        } else {
            return 2;
        }
        
    } else {
        
        if (section == 1 || section == 4) {
            return 1;
        } else if (section == 0) {
            return self.modelData.cartGoodsList.count;
        } else {
            return 2;
        }
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_sectionCount == 7) {
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (!indexPath.section) {
        //选择收货地址
        THAddressVC *addressVc = [[THAddressVC alloc] init];
        addressVc.getSelectAddress = ^(THAddressModel *addressModel) {
            self.selectAddressModel = addressModel;
            [self.mTable reloadData];
        };
        [self.navigationController pushViewController:addressVc animated:YES];
    }else if (indexPath.section == 4 && indexPath.row == 0){
        //选择优惠券
        THUseCouponCtl *selectCouponCtl = [[THUseCouponCtl alloc] init];
//        selectCouponCtl.dataSourceArray = self.modelData.userCartCouponList.mutableCopy;
        selectCouponCtl.selectCouponBlock = ^(THCouponsModel *couponModel) {
            self.couponsModel = couponModel;
            [self.mTable reloadData];
        };
        [self.navigationController pushViewController:selectCouponCtl animated:YES];
    }
    
}

#pragma mark - 地址cell
- (UITableViewCell*)addressCell:(UITableView *)tableView {
    THAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([THAddressCell class])];
    cell.addressModel = self.selectAddressModel;
    return cell;
}

#pragma mark - THBuyGoodsCell
- (UITableViewCell*)buyGoodsCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THBuyGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([THBuyGoodsCell class])];
    cell.modelData = self.modelData.cartGoodsList[indexPath.row];
    return cell;    
}

#pragma mark - THLogisticsCell
- (UITableViewCell*)logisticsCell:(UITableView *)tableView {
    THLogisticsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THLogisticsCell.class)];
    cell.modelData = self.modelData.shippingList;
    return cell;
}

#pragma mark - THOrderConfirmListCell
- (UITableViewCell *)orderConfirmListCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THOrderConfirmListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THOrderConfirmListCell.class)];
    NSInteger currentRow = _sectionCount == 7 ? 3 : 2;
    cell.leftLabel.text = _leftValues[indexPath.section-currentRow][indexPath.row];
    cell.rightLabel.text = _rightValues[indexPath.section-currentRow][indexPath.row];
    return cell;
}

#pragma mark - 懒加载
- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        [_mTable registerNib:[UINib nibWithNibName:@"THAddressCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THAddressCell.class)];
        [_mTable registerNib:[UINib nibWithNibName:@"THBuyGoodsCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THBuyGoodsCell.class)];
        [_mTable registerNib:[UINib nibWithNibName:@"THLogisticsCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THLogisticsCell.class)];
        [_mTable registerNib:[UINib nibWithNibName:@"THOrderConfirmListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THOrderConfirmListCell.class)];
    }
    return _mTable;
}

@end
