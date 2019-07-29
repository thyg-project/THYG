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

@interface THInvitationManageCtl ()<UITableViewDelegate,UITableViewDataSource, THFilterViewDelegate> {
    THFilterView *_filterView;
}
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic,strong) NSMutableArray *data;
//当前的位置：1.我的供应商 2.我的注册会员 3.推荐有奖
@property (nonatomic,assign) NSInteger curIndex;
@end

@implementation THInvitationManageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_filterView.mas_bottom).offset(1);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.curIndex) {
        case 0:
            return 3;
            break;
        case 1:
            return 5;
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.curIndex) {
        case 0:
        case 1:
            return 110;
            break;
        case 2:
            return 120;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.curIndex) {
        case 0:
        case 1: {
            THMySupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMySupplierCell.class)];
            
            return cell;
        }
            break;
        case 2: {
            THRecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THRecommendedCell.class)];
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mTable.backgroundColor = kBackgroundColor;
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THMySupplierCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMySupplierCell.class)];
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THRecommendedCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THRecommendedCell.class)];
    }
    return _mTable;
}

#pragma mark --
- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
    _curIndex = index;
    [self.mTable reloadData];
}

@end
