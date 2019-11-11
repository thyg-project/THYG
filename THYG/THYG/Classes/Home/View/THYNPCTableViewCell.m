//
//  THYNPCTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THYNPCTableViewCell.h"

@interface THYNPCTableViewCell() {
    UIButton *_buyButton;
}

@end

@implementation THYNPCTableViewCell

- (void)setup {
    [super setup];
    
    [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
    }];
    [_leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
    }];
    [_titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-8));
    }];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.bottom.equalTo(_leftImageView);
    }];
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyButton setImage:[UIImage imageNamed:@"YNPC_Buy"] forState:UIControlStateNormal];
    [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_buyButton];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_desLabel);
        make.right.equalTo(@(-16));
    }];
    
}

- (void)buy {
    
}

@end
