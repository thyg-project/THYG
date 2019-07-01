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

@interface THMineWalletVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) THMineWalletHeaderView *walletView;
@property (nonatomic, strong) NSArray *cardArray;
@end

@implementation THMineWalletVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    self.title = @"我的钱包"; 
    [self.view addSubview:self.tableView];
    [self loadDatas];
}

#pragma mark - 银行卡列表 （请求成功，未添加时候，没有数据）
- (void)loadDatas {
//    kWeakSelf;
//    [THNetworkTool POST:API(@"/User/wallet") parameters:@{@"token":@""} completion:^(id responseObject, NSDictionary *allResponseObject) {
//        NSLog(@"responseObject %@", responseObject);
//        
//        weakSelf.walletView.walletModel = [THWalletHeaderModel mj_objectWithKeyValues:responseObject[@"info"][@"money"]];
//        
//    }];
    
//    [THNetworkTool POST:API(@"/User/bankCardList") parameters:@{@"token":@""} completion:^(id responseObject, NSDictionary *allResponseObject) {
//         NSLog(@"responseObject %@", responseObject);
//     }];
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNaviHeight) style:UITableViewStylePlain];
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

- (NSArray *)cardArray {
    if (!_cardArray) {
        _cardArray = [NSArray array];
    }
    return _cardArray;
}

@end
