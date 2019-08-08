//
//  THAddressVC.m
//  THYG
//
//  Created by Mac on 2018/4/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressVC.h"
#import "THAddressModel.h"
#import "THAddressEditListCell.h"
#import "THAddressEditVC.h"

@interface THAddressVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) UIButton *addAddressBtn;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation THAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"收货地址";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.addAddressBtn];
    [self.addAddressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.addAddressBtn.mas_top);
    }];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark -- 跳转到添加界面
- (void)addAddressBtnClick {
    [self gotoAddressEditPage:nil type:newOption];
}

#pragma mark -- 跳转到编辑界面
- (void)gotoAddressEditPage:(THAddressModel*)model type:(optionType)optiontype {
    THAddressEditVC *vc = [[THAddressEditVC alloc] init];
    vc.optiontype = optiontype;
    vc.modelData = model;
    vc.optionSuccessBlock = ^{
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;//self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THAddressEditListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"THAddressEditListCell"];
    if (!cell) {
        cell = [[THAddressEditListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"THAddressEditListCell"];
    }
//    THAddressModel *model = self.dataSource[indexPath.section];;
//    cell.addressModel = model;
//    kWeakSelf;
    cell.deleteAddressBlock = ^{
        NSLog(@"删除地址");
        
    };

    cell.motifyAddressBlock = ^{
        NSLog(@"修改地址");
//        [weakSelf gotoAddressEditPage:model type:editOption];
    };

    cell.setDefaultBlock = ^{
        NSLog(@"设置默认地址");
        
    };

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.getSelectAddress) {
        self.getSelectAddress(self.dataSource[indexPath.section]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 懒加载
- (UIButton*)addAddressBtn {
    if (_addAddressBtn == nil) {
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAddressBtn.titleLabel.font = Font(15);
        _addAddressBtn.backgroundColor = [UIColor redColor];
        [_addAddressBtn setTitle: @"添加收货地址" forState:UIControlStateNormal];
        [_addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}
@end
