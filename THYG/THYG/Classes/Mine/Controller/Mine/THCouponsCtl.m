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
    THFilterView    *_filterView;
    THMenuView      *_menuView;
    BOOL            _updateCoupons;
    NSInteger       _selectedIndex;
    NSArray         *_results;
}
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) NSMutableArray *couponCenterDatas;
@property (nonatomic, strong) NSMutableArray *coupons;
@property (nonatomic, strong) UIButton *titleBtnView;

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
    return _results.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THCouponsCell" forIndexPath:indexPath];
    [cell refreshWithModel:[_results objectAtIndex:indexPath.row] type:_selectedIndex];
    kWeakSelf;
    cell.btnClickAcion = ^{
        kStrongSelf;
        //领取优惠券
        if (strongSelf->_selectedIndex) {
            
        } else {
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
    [self.couponPresenter filterWhere:index from:_selectedIndex ? self.couponCenterDatas : self.coupons];
}

- (void)menuView:(THMenuView *)menuView didSelectedItem:(NSString *)item index:(NSInteger)index {
    [menuView dismiss];
    self.titleBtnView.selected = NO;
    
    [self.titleBtnView setTitle:item forState:UIControlStateNormal];
    _selectedIndex = index;
    if (_updateCoupons == NO) {
        [self.mTable reloadData];
    } else {
        if (index == 0) {
            [self.couponPresenter getCouponList];
        } else {
            [self.couponPresenter getCouponCenterData];
        }
    }
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
        [_mTable registerNib:[UINib nibWithNibName:@"THCouponsCell" bundle:nil] forCellReuseIdentifier:@"THCouponsCell"];
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
    _updateCoupons = NO;
    self.coupons = [response mutableCopy];
    _results = [self.coupons copy];
    [self.mTable reloadData];
}

- (void)getCouponListFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getCouponCenterFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getCouponCenterSuccess:(NSArray<THCouponModel *> *)response {
    _updateCoupons = NO;
    self.couponCenterDatas = [response mutableCopy];
    _results = [self.couponCenterDatas copy];
    [self.mTable reloadData];
}

- (void)filterCouponResult:(NSArray<THCouponModel *> *)result {
    _results = result;
    [self.mTable reloadData];
}

@end
