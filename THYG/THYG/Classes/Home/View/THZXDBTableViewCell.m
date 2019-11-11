//
//  THZXDBTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THZXDBTableViewCell.h"

@interface THZXDBTableViewCell() {
    UILabel *_timeLabel;
}

@end

@implementation THZXDBTableViewCell

- (void)setup {
    [super setup];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(4);
    }];
    _timeLabel = [UILabel new];
    _timeLabel.text = @"01：25：27";
    _timeLabel.font = [UIFont systemFontOfSize:24];
    _timeLabel.textColor = UIColorHex(0xE11321);
    [_containerView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_leftImageView);
        make.left.equalTo(_desLabel);
    }];
}



@end


@implementation THQBDBTableViewCell

- (void)setup {
    [super setup];
    [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-16));
    }];
}

@end
