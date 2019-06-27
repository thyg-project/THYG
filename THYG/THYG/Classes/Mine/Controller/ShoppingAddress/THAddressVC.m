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

@interface THAddressVC ()
@property (nonatomic,strong) UIButton *addAddressBtn;
@end

@implementation THAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getAddressList];
}

#pragma mark - 设置UI
- (void)setupUI {
    self.title = @"收货地址";
    [self.view addSubview:self.dataTableView];
    self.dataTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataTableView.tableFooterView = [UIView new];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"THAddressEditListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THAddressEditListCell.class)];
    [self.view addSubview:self.addAddressBtn];
    
    self.dataTableView.rowHeight = UITableViewAutomaticDimension;
    
}

#pragma mark - 获取地址列表
- (void)getAddressList {
//    [THNetworkTool POST:API(@"/Address/getUserAddressList") parameters:@{@"token":@""} completion:^(id responseObject, NSDictionary *allResponseObject) {
//        self.dataSourceArray = [THAddressModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
//        [self.dataTableView reloadData];
//    }];
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
        [self refreshDataAction];
    };
    [self pushVC:vc];
}

#pragma mark -- 删除地址
- (void)deleteAddress:(NSString*)aid {
//    [THNetworkTool POST:API(@"/Address/delete") parameters:@{@"address_id":aid,@"token":@""} completion:^(id responseObject, NSDictionary *allResponseObject) {
//
//        [self refreshDataAction];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [THHUD showSuccess:@"删除成功"];
//        });
//    }];
}

#pragma mark -- 设置为默认地址
- (void)defaultBtnOnclick:(THAddressModel *)model {

//    [THNetworkTool POST:API(@"/Address/setDefault") parameters:@{@"token":@"", @"address_id":model.address_id} completion:^(id responseObject, NSDictionary *allResponseObject) {
//
//        [self refreshDataAction];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [THHUD showSuccess:@"设置成功"];
//            
//        });
//    }];
}

- (void)refreshDataAction {
    // self.isUp = NO;
    [self getAddressList];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSourceArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THAddressEditListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THAddressEditListCell.class)];
    THAddressModel *model = self.dataSourceArray[indexPath.section];;
    cell.addressModel = model;

    kWeakSelf;
    
    cell.deleteAddressBlock = ^{
        NSLog(@"删除地址");
        [weakSelf deleteAddress:model.address_id];
    };

    cell.motifyAddressBlock = ^{
        NSLog(@"修改地址");
        [weakSelf gotoAddressEditPage:model type:editOption];
    };

    cell.setDefaultBlock = ^{
        NSLog(@"设置默认地址");
        [weakSelf defaultBtnOnclick:model];
    };

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    THAddressModel *model = self.dataSourceArray[indexPath.section];
    return [self getSpaceLabelHeight:model.full_address withFont:[UIFont systemFontOfSize:12] withWidth:kScreenWidth-2*12] + 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.getSelectAddress) {
        self.getSelectAddress(self.dataSourceArray[indexPath.section]);
    }
    [self popVC];
}

#pragma mark - 懒加载
- (UIButton*)addAddressBtn {
    if (_addAddressBtn == nil) {
        _addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addAddressBtn.frame =  CGRectMake(0, kScreenHeight - 40 - kNaviHeight, kScreenWidth, 40);
       
        _addAddressBtn.titleLabel.font = Font(15);
        _addAddressBtn.backgroundColor = [UIColor redColor];
        [_addAddressBtn setTitle: @"添加收货地址" forState:UIControlStateNormal];
        [_addAddressBtn addTarget:self action:@selector(addAddressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addAddressBtn;
}

- (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = 1;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f
                          };
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    
    return size.height;
    
}

@end
