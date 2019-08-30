//
//  THTeHuiCenterVC.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCenterVC.h"
#import "THTeHuiCell.h"
#import "THTeHuiModel.h"
#import "THMenuView.h"
#import "THTeCenterPresenter.h"
#import "THFilterView.h"
#import "THTeCtl.h"


@interface THTeHuiCenterVC () <UITableViewDataSource, UITableViewDelegate, THMemuViewDelegate, THTeCenterProtocol, THFilterViewDelegate> {
    THFilterView *_filterView;
}
@property (nonatomic, strong) UIButton *titleBtnView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) THMenuView *menuView;
@property (nonatomic, strong) THTeCenterPresenter *presenter;


@end

@implementation THTeHuiCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THTeCenterPresenter alloc] initPresenterWithProtocol:self];
    [_presenter getTeData];
    [self setupUI];
    [self setMunes];
}

- (void)setMunes {
    _menuView = [THMenuView new];
    self.menuView.data = @[@"晒单",@"特"];
    _menuView.delegate = self;
    [self.view addSubview:self.menuView];
}

- (void)setupUI {
    self.navigationItem.titleView = self.titleBtnView;
    _filterView = [[THFilterView alloc] initWithDatas:@[@"综合",@"评论数",@"好评率"]];
    _filterView.delegate = self;
    [self.view addSubview:_filterView];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_filterView.mas_bottom);
    }];
    [self.tableView registerClass:[THTeHuiCell class] forCellReuseIdentifier:NSStringFromClass(THTeHuiCell.class)];
}

#pragma mark - UITableView 代理 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THTeHuiCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THTeHuiCell.class)];
    cell.commonModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

#pragma mark - 按钮点击事件
- (void)btnClick {
    if (CGRectGetHeight(self.menuView.visibleRect) > 0) {
        self.titleBtnView.selected = NO;
        [self.menuView dismiss];
    } else {
        [self.menuView show];
        self.titleBtnView.selected = YES;
    }
}

#pragma mark - titleBtnView
- (UIButton *)titleBtnView {
    if (!_titleBtnView) {
        _titleBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtnView.frame = CGRectMake(0, 0, 100, 40);
        [_titleBtnView setTitle:@"晒单" forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        _titleBtnView.titleLabel.font = Font(15);
        [_titleBtnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtnView;
}

#pragma mark --THMenuViewDelegate
- (void)menuView:(THMenuView *)menuView didSelectedItem:(NSString *)item index:(NSInteger)index {
    self.titleBtnView.selected = NO;
    [self.titleBtnView setTitle:item forState:UIControlStateNormal];
    [menuView dismiss];
}

- (void)menuViewDismiss:(THMenuView *)menuView {
    [menuView dismiss];
    self.titleBtnView.selected = NO;
}

- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
    
}
#pragma mark --Protocol
- (void)loadTeSuccess:(NSArray<THTeHuiModel *> *)response {
    _dataSource = response.mutableCopy;
}

- (void)loadTeFailed:(NSDictionary *)errorInfo {
    
}
@end
