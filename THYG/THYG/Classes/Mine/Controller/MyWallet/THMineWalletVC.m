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
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (indexPath.row == 0) {
		THMineAddBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineAddBankCardCell.class)];
		return cell;
		
	} else {
		THMineBankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineBankCardCell.class)];
		return cell;
	
	}

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	if (indexPath.row != 0) {
		THMineBankCardVC *banckVc = [[THMineBankCardVC alloc] init];
        [self.navigationController pushViewController:banckVc animated:YES];
	}
	
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return self.walletView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row != 0) {
		return 180;
	}
    return 44;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		[_tableView registerNib:[UINib nibWithNibName:@"THMineAddBankCardCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMineAddBankCardCell.class)];
		[_tableView registerNib:[UINib nibWithNibName:@"THMineBankCardCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMineBankCardCell.class)];
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

- (void)getWalletInfoSuccess:(id)response {
    
}

- (void)getWalletInfoFailed:(NSDictionary *)errorInfo {
    
}

@end
