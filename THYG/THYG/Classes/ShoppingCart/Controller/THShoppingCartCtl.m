//
//  THShoppingCartCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartCtl.h"
#import "THShoppingCartListDelegate.h"
#import "THShoppingCartModel.h"
#import "THOrderConfirmCtl.h"
#import "THShareView.h"
#import "THCardSettleView.h"
#import "THCardPresenter.h"
#import "THCardHeader.h"
#import "THCardEmptyView.h"

@interface THShoppingCartCtl () <THCardSettleDelegate, THCardProtocol,THTableViewDelegate> {
    THCardSettleView *_settleView;
    THCardHeader *_header;
    UIScrollView *_containerView;
}
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) THShoppingCartListDelegate *tableDelegate;
@property (nonatomic, strong) THCardPresenter *presenter;
@property (nonatomic, strong) THShareView *shareView;
@property (nonatomic, strong) THCardEmptyView *emptyView;

@end

@implementation THShoppingCartCtl

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THCardPresenter alloc] initPresenterWithProtocol:self];
    [_presenter getShoppingCardList];
    [self setupUI];
}

- (THShareView *)shareView {
    if (!_shareView) {
        _shareView = [[THShareView alloc] initShareView];
        _shareView.container = self;
        [_shareView setSelectItemBlock:^(NSInteger index) {
            
        }];
    }
    return _shareView;
}

#pragma mark - 设置视图
- (void)setupUI {
    _containerView = [UIScrollView new];
    _containerView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_containerView];
    _settleView = [THCardSettleView new];
    _settleView.operaType = THCardOperaType_Settle;
    _settleView.delegate = self;
    [_settleView updateContentText:@"0"];
    [self.view addSubview:_settleView];
    [_settleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(_settleView.mas_top);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(kScreenHeight - 50 - kTabBarHeight);
    }];
    _header = [THCardHeader new];
    [_containerView addSubview:_header];
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_containerView);
        make.height.mas_equalTo(kStatesBarHeight + 140/*79*/);
    }];
    self.emptyView.hidden = YES;
    [_containerView addSubview:self.mTable];
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_containerView);
        make.bottom.equalTo(_settleView.mas_top);
        make.top.equalTo(@(79 + kStatesBarHeight));
    }];
    
}


#pragma mark --
- (void)share:(THCardSettleView *)settleView {
    THShareObject *object = [THShareObject new];
    object.content = @"购物车";
    object.thumbnail = [UIImage imageNamed:@"AppIcon"];
    self.shareView.shareObject = object;
    [self.shareView showInView:self.tabBarController.view];
}

- (void)settle:(THCardSettleView *)settleView {
    
}

- (void)selectedAll:(THCardSettleView *)settleView selected:(BOOL)selected {
    [_settleView updateContentText:@"0"];
}

- (void)move:(THCardSettleView *)settleView {
    
}

- (void)deleteGoods:(THCardSettleView *)settleView {
    
}

#pragma mark - 懒加载
- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mTable.backgroundColor = [UIColor clearColor];
        [self autoLayoutSizeContentView:_mTable];
        [self.tableDelegate registerTable:_mTable];
        _mTable.delegate = self.tableDelegate;
        _mTable.dataSource = self.tableDelegate;
    }
    return _mTable;
}

- (THCardEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [THCardEmptyView new];
        [_emptyView setToOther:^{
            
        }];
        [_containerView addSubview:_emptyView];
        [_emptyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.view);
            make.bottom.equalTo(_settleView.mas_top);
        }];
    }
    return _emptyView;
}

- (THShoppingCartListDelegate *)tableDelegate {
    if (!_tableDelegate) {
        _tableDelegate = [[THShoppingCartListDelegate alloc] init];
        _tableDelegate.delegate = self;
    }
    return _tableDelegate;
}

#pragma mark--
- (void)changedGoodsNumber:(NSString *)cardId num:(NSInteger)num selected:(BOOL)selected {
    
}

- (void)singleGoodsDidSelected:(BOOL)selected {
    
}

#pragma mark--
- (void)moveToCollectSuccess:(NSDictionary *)info {
    
}

- (void)moveToCollectFailed:(NSDictionary *)errorInfo {
    
}

- (void)deleteGoodsSuccess:(NSDictionary *)info {
    
}

- (void)deleteGoodsFailed:(NSDictionary *)errorInfo {
    
}

- (void)selectedAllSuccess:(NSDictionary *)info {
    
}

- (void)selectedAllFailed:(NSDictionary *)errorInfo {
    
}

- (void)getShoppingCardListSuccess:(NSArray *)list {
    
}

- (void)getShoppingCardListFailed:(NSDictionary *)errorInfo {
    
}

- (void)changedGoodsNumberSuccess:(NSDictionary *)response {
    
}

- (void)changedGoodsNumberFailed:(NSDictionary *)errorInfo {
    
}

@end
