//
//  THFlashCtl.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THFlashCtl.h"
#import "THGoodsDetailVC.h"
#import "THSpellGroupHead.h"
#import "THFlashSaleModel.h"
#import "THFlashPresenter.h"
#import "THSHMSTableViewCell.h"

@interface THFlashCtl () <UITableViewDelegate, UITableViewDataSource,THFlashProtocol>
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) THSpellGroupHead *headView;

@property (nonatomic, strong) THFlashPresenter *presenter;
@end

@implementation THFlashCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"限时秒杀";
    _presenter = [[THFlashPresenter alloc] initPresenterWithProtocol:self];
    [self setNavigationBarColor:UIColorHex(0xE11321)];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;//self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THSHMSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self autoLayoutSizeContentView:_tableView];
        [_tableView registerClass:[THSHMSTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (THSpellGroupHead *)headView {
    if (!_headView) {
        _headView = [[THSpellGroupHead alloc] initWithFrame:CGRectZero];
    }
    return _headView;
}

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

- (void)loadFlashDataSuccess:(NSArray *)data {
    
}

- (void)loadFlashDataFailed:(NSDictionary *)errorInfo {
    
}

@end
