//
//  THCreateOrderSuccessCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCreateOrderSuccessCtl.h"
#import "THPayMethodCtl.h"
#import "THOrderConfirmPayButtomView.h"
#import "THOrderConfirmPaymentCell.h"
#import "THPay.h"
#import "THPaySuccessBlockPage.h"

@interface THCreateOrderSuccessCtl () <UITableViewDataSource, UITableViewDelegate> {
    NSArray * _itemArray;
}
@property (nonatomic, strong) THOrderConfirmPayButtomView *payView;
@property (nonatomic, assign) NSInteger currentRow;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation THCreateOrderSuccessCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置UI
- (void)setupUI {
    
    self.navigationItem.title = @"收银台";
    [self.view addSubview:self.payView];
    [self.payView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
//        make.height.offset(kTabBarHeight);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THOrderConfirmPaymentCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THOrderConfirmPaymentCell.class)];
    
    _itemArray = @[@{@"iconImage":@"bank", @"title":@"银行卡"},
                   @{@"iconImage":@"pay", @"title":@"支付宝"},
                   @{@"iconImage":@"wx", @"title":@"微信"}];
    
    self.payView.price = [NSString stringWithFormat:@"￥%.2f", self.totalPrice];
    #pragma mark - 立即支付
    kWeakSelf;
    self.payView.payBlock = ^{
        kStrongSelf;
        if (strongSelf.currentRow > 1) {
            [strongSelf payMethod];
        }
        if (!strongSelf.currentRow) {
            [THHUDProgress showMsg:@"请选择支付方式"];
        }
    };
}

#pragma mark - payMethod
- (void)payMethod {
    
    //微信支付成功回调
    [THPay weChatPay:nil success:^(id response) {
         [THHUDProgress showSuccess:@"微信支付成功"];
    } failed:^(id errorInfo) {
        
    }];
    
    //支付宝支付成功回调
    [THPay aliPay:nil success:^(id response) {
         [THHUDProgress showSuccess:@"支付宝支付成功"];
    } failed:^(id errorInfo) {
        
    }];

    
}

#pragma mark - tableView 数据源代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THOrderConfirmPaymentCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THOrderConfirmPaymentCell.class)];
    cell.cellDict = _itemArray[indexPath.row];
    
    kWeakObject(cell)
    cell.selectedBlock = ^(BOOL isSelected) {
        
        if (isSelected && indexPath.row) {
            [tableView.visibleCells enumerateObjectsUsingBlock:^(THOrderConfirmPaymentCell * cell, NSUInteger row, BOOL * _Nonnull stop) {
                cell.isSelected = NO;
            }];
            weakObject.isSelected = YES;
            _currentRow = indexPath.row + 1;
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

#pragma mark - 懒加载
- (THOrderConfirmPayButtomView *)payView {
    if (!_payView) {
        _payView = [THOrderConfirmPayButtomView payButtomView];
    }
    return _payView;
}

#pragma mark -- 立即支付
- (IBAction)payBtnClick:(id)sender {
    
    THPayMethodCtl *pay = [[THPayMethodCtl alloc] init];
    pay.orderId = self.orderId;
    pay.totalPrice = self.totalPrice;
    [self.navigationController pushViewController:pay animated:YES];
}

#pragma matk -- 再去逛逛
- (IBAction)viewOtherBtn:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
