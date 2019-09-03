//
//  THMineBankCardVC.m
//  THYG
//
//  Created by Victory on 2018/6/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineBankCardVC.h"
#import "THMineBankCardListCell.h"
#import "THBankPresenter.h"

@interface THMineBankCardVC () <UITableViewDelegate, UITableViewDataSource, THBankProtocol>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) THBankPresenter *bankPresenter;
@end

@implementation THMineBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _bankPresenter = [[THBankPresenter alloc] initPresenterWithProtocol:self];
    [_bankPresenter getBankList];
	[self setupUI];
}

#pragma mark - 设置UI界面
- (void)setupUI {
	self.navigationItem.title = @"银行卡";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    [self autoLayoutSizeContentView:self.tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
	[self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
	[self.tableView registerNib:[UINib nibWithNibName:@"THMineBankCardListCell" bundle:nil] forCellReuseIdentifier:@"THMineBankCardListCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	THMineBankCardListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THMineBankCardListCell" forIndexPath:indexPath];
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 140;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
	if (section == 1) {
	}
	return nil;
}

- (void)getBankListFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getBankListSuccess:(NSArray<THBankCardModel *> *)response {
    _dataSource = response.mutableCopy;
    [self.tableView reloadData];
}

@end
