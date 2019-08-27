//
//  THAddressEditListCell.m
//  THYG
//
//  Created by Mac on 2018/5/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAddressEditListCell.h"
#import "THAddressModel.h"
#import "THButton.h"

@interface THAddressEditListCell() {

}

@property (nonatomic, strong) UILabel *nameLabel, *mobileLabel, *addressLabel;
@property (nonatomic, strong) THButton *defaultButton, *editButton, *deleteButton;

@end

@implementation THAddressEditListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _nameLabel = [UILabel new];
    _mobileLabel = [UILabel new];
    _addressLabel = [UILabel new];
    _addressLabel.numberOfLines = 0;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _addressLabel.font = [UIFont systemFontOfSize:12];
    _mobileLabel.font = [UIFont systemFontOfSize:16];
    _defaultButton = [THButton buttonWithType:THButtonType_imageLeft];
    _defaultButton.image = [UIImage imageNamed:@"unselect"];
    _defaultButton.selectedImage = [UIImage imageNamed:@"select"];
    _defaultButton.title = @"默认地址";
    _editButton = [THButton buttonWithType:THButtonType_imageLeft];
    _editButton.image = [UIImage imageNamed:@"sp"];
    _editButton.title = @"编辑";
    _deleteButton = [THButton buttonWithType:THButtonType_imageLeft];
    _deleteButton.image = [UIImage imageNamed:@"shanchu_red"];
    _deleteButton.title = @"删除";
    _defaultButton.font = [UIFont systemFontOfSize:14];
    _editButton.font = [UIFont systemFontOfSize:14];
    _deleteButton.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.mobileLabel];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.defaultButton];
    [self.contentView addSubview:self.editButton];
    [self.contentView addSubview:self.deleteButton];
    [self.defaultButton addTarget:self action:@selector(setDefaultAddress)];
    UILabel *line = [UILabel new];
    line.backgroundColor = kLineColor;
    [self.contentView addSubview:line];
    [self.deleteButton addTarget:self action:@selector(deleteAction)];
    [self.editButton addTarget:self action:@selector(eidtAction)];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(16));
        make.left.equalTo(@12);
        make.height.mas_equalTo(16);
    }];
    [self.mobileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_right).offset(22);
        make.top.height.equalTo(self.nameLabel);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(16);
        make.left.equalTo(@12);
        make.right.equalTo(@(-12));
    }];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addressLabel.mas_bottom).offset(15);
        make.left.equalTo(@12);
        make.right.equalTo(@(-12));
        make.height.mas_equalTo(1);
    }];
    [self.defaultButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(line.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
        make.bottom.equalTo(@(-5));
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.defaultButton);
        make.right.equalTo(@(-12));
        make.centerY.equalTo(self.defaultButton);
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.deleteButton);
        make.right.equalTo(self.deleteButton.mas_left).offset(-12);
        make.centerY.equalTo(self.defaultButton);
    }];
    [self defaultText];
}

- (void)defaultText {
    self.nameLabel.text = @"测试";
    self.mobileLabel.text = @"17621984643";
    self.addressLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试";
}

- (void)setDefaultAddress {
    _defaultButton.selected = !_defaultButton.selected;
    BLOCK(self.setDefaultBlock,self.addressModel);
}

- (void)deleteAction {
    BLOCK(self.deleteAddressBlock,self.addressModel);
}

- (void)eidtAction {
    BLOCK(self.motifyAddressBlock,self.addressModel);
}

- (void)setAddressModel:(THAddressModel *)addressModel {
    _addressModel = addressModel;
    self.nameLabel.text = _addressModel.consignee;
    self.mobileLabel.text = _addressModel.mobile;
    self.addressLabel.text = _addressModel.full_address;
    self.defaultButton.selected = _addressModel.is_default;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
