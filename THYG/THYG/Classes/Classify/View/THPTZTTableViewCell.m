//
//  THPTZTTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THPTZTTableViewCell.h"

@interface THPTZTTableViewCell() {
    UIButton *_buyButton;
}

@end

@implementation THPTZTTableViewCell

- (void)setup {
    [super setup];
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyButton setTitle:@"去开团" forState:UIControlStateNormal];
    _buyButton.backgroundColor = UIColorHex(0xE81D19);
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_buyButton setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = WIDTH(30) / 2.0;
    [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_buyButton];
    [_leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
    }];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-8));
        make.right.equalTo(@(-8));
        make.size.mas_equalTo(CGSizeMake(WIDTH(96), WIDTH(30)));
    }];
    _pLabel.font = [UIFont systemFontOfSize:16];
    _desLabel.layer.cornerRadius = 0;
    _desLabel.backgroundColor = UIColor.clearColor;
    _desLabel.textColor = UIColorHex(0x989898);
    [_pLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.right.equalTo(_titleLabel);
        make.height.mas_equalTo(33);
    }];
    [_desLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(82, 14));
        make.left.equalTo(_pLabel);
        make.bottom.equalTo(_leftImageView.mas_bottom);
    }];
}

- (void)buy {
    
}

@end
