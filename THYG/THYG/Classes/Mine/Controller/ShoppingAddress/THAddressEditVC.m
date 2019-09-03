//
//  THAddressEditVC.m
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressEditVC.h"
#import "THAdressEditPresenter.h"
#import "THAddAddressCell.h"
#import "YGAreaPickerView.h"

@interface THAddressEditVC () <UITableViewDataSource, UITableViewDelegate, THAddressEditProtocol, YGAreaPickerViewDelegate> {
    UIButton*_saveBtn;
}

@property (nonatomic, strong) YGAreaPickerView *pickerView;
@property (nonatomic, strong) THAddressModel *valueModel;
@property (nonatomic, strong) YGProvince *provinceModel;
@property (nonatomic, strong) YGCity *cityModel;
@property (nonatomic, strong) YGDistrict *districtModel;
@property (nonatomic, strong) UIButton *footerBtn;
@property (nonatomic, strong) THAdressEditPresenter *presenter;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THAddressEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THAdressEditPresenter alloc] initPresenterWithProtocol:self];
    [self setupUI];
    [self initData];
}

- (void)setupUI {
    self.navigationItem.title = @"收货地址";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self autoLayoutSizeContentView:self.tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.footerBtn];
    [self.footerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.footerBtn.mas_top);
    }];
    [self.tableView registerClass:THAddAddressCell.class forCellReuseIdentifier:NSStringFromClass(THAddAddressCell.class)];
}

- (void)initData {
    NSArray *titleData = @[@"收货人",@"手机号码",@"选择地区",@"详细地址"];
    NSArray *typeData = @[@"1",@"1",@"2",@"1"];
    NSArray *placeholdData =  @[@"请输入收货人姓名",@"请输入手机号码",@"请选择地区",@"请输入详细地址"];
    NSArray *valueData = nil;
    if (self.optiontype != OptionType_New) {
        valueData = @[self.modelData.consignee, self.modelData.mobile, [NSString stringWithFormat:@"%@ %@ %@", self.modelData.province_str, self.modelData.city_str, self.modelData.district_str], self.modelData.address];
    }
    self.optiontype == OptionType_New ? nil : (self.valueModel = self.modelData);
    _dataSource = [NSMutableArray new];
    NSInteger index = 0;
    for (NSString*string in titleData) {
        THAddressModel *model = [[THAddressModel alloc]init];
        model.title = string;
        model.type = [typeData[index] integerValue];
        model.placehold = placeholdData[index];
        model.text = valueData[index];
        [self.dataSource addObject:model];
        index++;
    }
    [self.tableView reloadData];
    
    [self checkParmaMethod];
}

#pragma mark - 获取
- (void)checkParmaMethod {
    //收件人
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:[self getTextField:0]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:[self getTextField:1]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:[self getTextField:2]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:[self getTextField:3]];
    [_saveBtn setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forState:UIControlStateNormal];
    [_saveBtn setBackgroundImage:[UIImage imageWithColor:[[UIColor redColor] colorWithAlphaComponent:0.5]] forState:UIControlStateDisabled];
}

- (void)textDidChanged:(NSNotification *)not {
    UITextField *textF = not.object;
    if (textF == [self getTextField:1] && textF.text.length > 11) {
        [self getTextField:1].text = [textF.text substringToIndex:11];
    }
    if (YGInfo.validString([self getTextField:0].text) && [Utils checkPhoneNum:[self getTextField:1].text] && YGInfo.validString([self getTextField:2].text) && YGInfo.validString([self getTextField:3].text)) {
        _saveBtn.enabled = YES;
    } else {
        _saveBtn.enabled = NO;
    }
}

- (NSString*)getValue:(NSInteger)row {
    return ((THAddAddressCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).textField.text.length ? ((THAddAddressCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).textField.text : @"";
}

- (UITextField*)getTextField:(NSInteger)row {
    return ((THAddAddressCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).textField;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THAddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THAddAddressCell.class)];
    cell.modelData = self.dataSource[indexPath.row];
    cell.indexPath = indexPath;
    cell.textField.keyboardType = UIKeyboardTypeDefault;
    switch (indexPath.row) {
        case 0:
            cell.textField.text = self.valueModel.consignee;
            break;
        case 1:
            cell.textField.keyboardType = UIKeyboardTypeNumberPad;
            cell.textField.text = self.valueModel.mobile;
            break;
        case 3:
            cell.textField.text = self.valueModel.address;
        default:
            break;
    }
    cell.getInsertValue = ^(NSString *value) {
        
        switch (indexPath.row) {
            case 0:
                self.valueModel.consignee = value;
                break;
            case 1:
                self.valueModel.mobile = value;
                break;
            case 3:
                self.valueModel.address = value;
            default:
                break;
        }
        
    };
    kWeakSelf;
    [cell setShowAlertPop:^(NSIndexPath *indexPath) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            return YES;
        }
        [weakSelf.view endEditing:YES];
        [weakSelf.pickerView showInView:weakSelf.navigationController.view];
        return NO;
    }];
    return cell;
}

#pragma mark - 保存并使用
- (void)saveAndUseClick {
    NSString *address = [NSString stringWithFormat:@"%@%@%@", self.modelData.province_str, self.modelData.city_str, self.modelData.district_str];
    if ([self getTextField:3].text.length < address.length) {
        address = [self getTextField:3].text;
    } else {
        address = [[self getTextField:3].text substringFromIndex:address.length-1];
    }
    [self.presenter newAddress:nil];
}

#pragma mark - 懒加载
- (UIButton *)footerBtn {
    if (!_footerBtn) {
        _footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_footerBtn setBackgroundColor:[UIColor redColor]];
        [_footerBtn setTitle:@"保存并使用" forState:UIControlStateNormal];
        _footerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_footerBtn addTarget:self action:@selector(saveAndUseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _footerBtn;
}

- (YGAreaPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[YGAreaPickerView alloc] init];
        _pickerView.delegate = self;
    }
    return _pickerView;
}

#pragma mark --
- (void)editAddressFailed:(NSDictionary *)errorInfo {
    
}

- (void)eidtAddressSuccess:(NSDictionary *)response {
    if ([self.delegate respondsToSelector:@selector(updateAddress:)]) {
        [self.delegate updateAddress:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newAddressSuccess:(NSDictionary *)response {
    if ([self.delegate respondsToSelector:@selector(newAddress:)]) {
        [self.delegate newAddress:self];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)newAddressFailed:(NSDictionary *)errorInfo {
    
}

- (void)didSelectedPro:(YGProvince *)pro city:(YGCity *)city area:(YGDistrict *)area {
    
    self.provinceModel = pro;
    self.cityModel = city;
    self.districtModel = area;

    THAddressPCDModel *model = self.dataSource[2];
    model.text = [NSString stringWithFormat:@"%@ %@ %@",pro.name,city.name,area.name];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
