//
//  THMineWalletVC.m
//  THYG
//
//  Created by Mac on 2018/4/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineWalletVC.h"
#import "THMineBankCardVC.h"
#import "THMineWalletHeaderView.h"
#import "THAcountDetailCtl.h"
#import "THMineAddBankCardCell.h"
#import "THMineBankCardCell.h"
#import "THWalletHeaderModel.h"
#import "THWalletPresenter.h"
#import "THAddBankViewController.h"

@interface THMineWalletVC () <UITableViewDataSource, UITableViewDelegate, THWalletProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) THMineWalletHeaderView *walletView;
@property (nonatomic, strong) NSArray *cardArray;
@property (nonatomic, strong) THWalletPresenter *walletPresenter;
@end

@implementation THMineWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _walletPresenter = [[THWalletPresenter alloc] initPresenterWithProtocol:self];
    [THHUDProgress show];
    [_walletPresenter getWalletInfo];
    [self setupUI];
}

- (void)setupUI {
    self.navigationItem.title = @"我的钱包";
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cardArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMineBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THMineBankCardCell"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    THMineBankCardVC *controller = [[THMineBankCardVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THMineAddBankCardCell *view = [[NSBundle mainBundle] loadNibNamed:@"THMineAddBankCardCell" owner:nil options:nil].firstObject;
    [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBank)]];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"THMineBankCardCell" bundle:nil] forCellReuseIdentifier:@"THMineBankCardCell"];
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 320)];
        headerView.backgroundColor = UIColor.whiteColor;
        [headerView addSubview:self.walletView];
        [self.walletView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView);
        }];
        _tableView.tableHeaderView = headerView;
    }
    return _tableView;
}

- (THMineWalletHeaderView *)walletView {
    if (!_walletView) {
        _walletView = [THMineWalletHeaderView walletView];
        kWeakSelf;
        //余额充值/提现
        _walletView.withdrawBtnAction = ^(NSInteger tag, NSString *title) {
            
        };
        //金额明细
        _walletView.detailBtnAction = ^(NSInteger tag, NSString *title) {
            THAcountDetailCtl *acountDetail = [[THAcountDetailCtl alloc] init];
            acountDetail.title = title;
            acountDetail.balanceCateType = tag;
            [weakSelf.navigationController pushViewController:acountDetail animated:YES];
        };
    }
    return _walletView;
}

- (void)addBank {
    THAddBankViewController *controller = [THAddBankViewController new];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)getWalletInfoSuccess:(THWalletHeaderModel *)info {
    [THHUDProgress dismiss];
    self.walletView.walletModel = info;
}

- (void)getWalletInfoFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

@end
