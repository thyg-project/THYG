//
//  THCouponsCtl.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCouponsCtl.h"
#import "THCouponsCell.h"
#import "THFilterView.h"
#import "THMenuView.h"
#import "THCouponPresenter.h"

@interface THCouponsCtl ()<UITableViewDelegate,UITableViewDataSource, THFilterViewDelegate, THMemuViewDelegate, THCouponProtocol> {
    THFilterView *_filterView;
    THMenuView *_menuView;
}
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic,strong) NSMutableArray *canGetData;
@property (nonatomic,strong) NSMutableArray *getedData;
@property (nonatomic,strong) UIButton *titleBtnView;
@property (nonatomic,assign) NSInteger type;//0.我的优惠券 1.领券中心
@property (nonatomic, strong) THCouponPresenter *couponPresenter;
@end

@implementation THCouponsCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    _couponPresenter = [[THCouponPresenter alloc] initPresenterWithProtocol:self];
    [_couponPresenter getCouponList];
    self.navigationItem.title = @"优惠券";
    _filterView = [[THFilterView alloc] initWithDatas:@[@"全部",@"通用券",@"指定券",@"筛选"]];
    _filterView.delegate = self;
    [_filterView setImage:[UIImage imageNamed:@"shaixuan"] selectedImage:[UIImage imageNamed:@"shaixuan"] index:3];
    _filterView.imageMargenToText = 5;
    _filterView.selectedColor = [UIColor redColor];
    [self.view addSubview:_filterView];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    self.navigationItem.titleView = self.titleBtnView;
    
    [self.view addSubview:self.mTable];
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_filterView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    [self setUpMenuView];
}

- (void)setUpMenuView {
    _menuView = [[THMenuView alloc] init];
    _menuView.itemAlignment = THMenuViewItemTextAlignment_Left;
    _menuView.data = @[@"我的优惠券",@"领券中心"];
    _menuView.delegate = self;
    [self.view addSubview:_menuView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.type?self.canGetData.count:self.getedData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THCouponsCell.class)];
    [cell refreshWithModel:self.type?self.canGetData[indexPath.row]:self.getedData[indexPath.row] type:self.type];
    cell.btnClickAcion = ^{
      
        //领取优惠券
        if (self.type) {
            
        }else{
            //使用优惠券
        }
        
    };
    return cell;
}

- (void)btnClick {
    if (self.titleBtnView.selected) {
        [_menuView dismiss];
        self.titleBtnView.selected = NO;
        return;
    }
    [_menuView show];
    self.titleBtnView.selected = YES;
}

- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
    
}

- (void)menuView:(THMenuView *)menuView didSelectedItem:(NSString *)item index:(NSInteger)index {
    [menuView dismiss];
    self.titleBtnView.selected = NO;
    
    [self.titleBtnView setTitle:item forState:UIControlStateNormal];
    self.type = index;
    if (index == 0) {
        [self.couponPresenter getCouponList];
    } else {
        [self.couponPresenter getCouponCenterData];
    }
    [self.mTable reloadData];
}

- (void)menuViewDismiss:(THMenuView *)menuView {
    [menuView dismiss];
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = kBackgroundColor;
        _mTable.tableFooterView = [UIView new];
        _mTable.allowsSelection = NO;
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THCouponsCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THCouponsCell.class)];
    }
    return _mTable;
}

- (UIButton *)titleBtnView {
    if (!_titleBtnView) {
        _titleBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtnView.frame = CGRectMake(0, 0, 100, 40);
        [_titleBtnView setTitle:@"我的优惠券" forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        _titleBtnView.titleLabel.font = Font(15);
        [_titleBtnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtnView;
}

- (void)getCouponListSuccess:(NSArray<THCouponModel *> *)response {
    
}

- (void)getCouponListFailed:(NSDictionary *)errorInfo {
    
}

- (void)getCouponCenterFailed:(NSDictionary *)errorInfo {
    
}

- (void)getCouponCenterSuccess:(NSArray<THCouponModel *> *)response {
    
}

@end
