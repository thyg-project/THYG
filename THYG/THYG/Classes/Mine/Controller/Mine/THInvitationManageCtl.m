//
//  THInvitationManageCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THInvitationManageCtl.h"
#import "THMySupplierCell.h"
#import "THRecommendedCell.h"
#import "THFilterView.h"
#import "THInvitePresenter.h"

@interface THInvitationManageCtl ()<UITableViewDelegate,UITableViewDataSource, THFilterViewDelegate, THInviteProtocol> {
    THFilterView *_filterView;
    NSArray *_results;
}
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic,strong) NSMutableArray *data;
//当前的位置：1.我的供应商 2.我的注册会员 3.推荐有奖
@property (nonatomic,assign) NSInteger curIndex;

@property (nonatomic, strong) THInvitePresenter *invitePresenter;
@end

@implementation THInvitationManageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    _invitePresenter = [[THInvitePresenter alloc] initPresenterWithProtocol:self];
    [_invitePresenter getInviteData];
    self.navigationItem.title = @"邀请管理";
    _curIndex = 1;
    _filterView = [[THFilterView alloc] initWithDatas:@[@"我的供应商",@"我的注册会员",@"推荐有奖"]];
    _filterView.selectedColor = [UIColor redColor];
    _filterView.delegate = self;
    _filterView.selectedIndex = 0;
    [self.view addSubview:_filterView];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.mTable];
    [self autoLayoutSizeContentView:self.mTable];
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_filterView.mas_bottom).offset(1);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _results.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = CGFLOAT_MIN;
    if (_curIndex == 0 || _curIndex == 1) {
        height = 110;
    } else {
        height = 120;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (self.curIndex == 0 || self.curIndex == 1) {
        THMySupplierCell *myCell = [tableView dequeueReusableCellWithIdentifier:@"THMySupplierCell" forIndexPath:indexPath];
        cell = myCell;
    } else {
        THRecommendedCell *Recell = [tableView dequeueReusableCellWithIdentifier:@"THRecommendedCell" forIndexPath:indexPath];
        cell = Recell;
    }
    return cell;
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mTable.backgroundColor = kBackgroundColor;
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerNib:[UINib nibWithNibName:@"THMySupplierCell" bundle:nil] forCellReuseIdentifier:@"THMySupplierCell"];
        [_mTable registerNib:[UINib nibWithNibName:@"THRecommendedCell" bundle:nil] forCellReuseIdentifier:@"THRecommendedCell"];
    }
    return _mTable;
}

#pragma mark --
- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
    _curIndex = index;
    [self.invitePresenter filterDataWhereState:_curIndex fromSource:self.data];
}

- (void)getInviteDataFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getInviteDataSuccess:(NSArray<THInviteInfoModel *> *)response {
    _data = [response mutableCopy];
    _results = _data;
    [self.mTable reloadData];
}

- (void)filterDataResults:(NSArray<THInviteInfoModel *> *)results {
    _results = results;
    [self.mTable reloadData];
}

@end
