//
//  THWDDBTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THWDDBTableViewCell.h"
#import "YYLabel.h"

@interface THWDDBTableViewCell() {
    UILabel *_leftLabel;
    UILabel *_contentLabel;
    
}

@end

@implementation THWDDBTableViewCell

- (void)setup {
    [super setup];
    _titleLabel.numberOfLines = 1;
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.top.equalTo(_titleLabel.mas_bottom).offset(4);
    }];
    _desLabel.textColor = UIColorHex(0xE11321);
    _desLabel.font = [UIFont systemFontOfSize:16];
    _leftLabel = [UILabel new];
    _leftLabel.textColor = UIColorHex(0x989898);
    _leftLabel.font = [UIFont systemFontOfSize:12];
    [_containerView addSubview:_leftLabel];
    _contentLabel = [UILabel new];
    _contentLabel.textColor = UIColorHex(0x989898);
    _contentLabel.numberOfLines = 0;
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [_containerView addSubview:_contentLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_desLabel);
        make.top.equalTo(_desLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(26);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftLabel.mas_right);
        make.top.equalTo(_desLabel.mas_bottom).offset(2);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(_containerView).offset(-16);
    }];
    [self settext];
}

- (void)settext {
    _titleLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试";
    _desLabel.text = @"开奖倒计时开奖倒计时";
    _leftLabel.text = @"夺宝号码：";
    _contentLabel.text = @"51234 54362 56723 52346 51234 54362 56723 52346 51234 54362 56723 52346 51234 54362 56723 52346 51234 54362 56723 52346 51234 54362 56723 52346";
    
}


@end

@interface THWDDB1TableViewCell() {
    UILabel *_subLabel;
}
- (void)settext;

@end

@implementation THWDDB1TableViewCell

- (void)setup {
    [super setup];
    _titleLabel.numberOfLines = 1;
    [_leftImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.left.top.equalTo(@16);
       make.size.mas_equalTo(CGSizeMake(96, 96));
        make.bottom.equalTo(@(-16));
    }];
    _desLabel.textColor = UIColorHex(0x717171);
    _desLabel.font = [UIFont systemFontOfSize:12];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.top.equalTo(_titleLabel.mas_bottom).offset(4);
    }];
    _subLabel = [UILabel new];
    [_containerView addSubview:_subLabel];
    _subLabel.textColor = UIColorHex(0x989898);
    _subLabel.font = [UIFont systemFontOfSize:12];
    [_subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.top.equalTo(_desLabel.mas_bottom).offset(4);
    }];
    [self settext];
}

- (void)settext {
     _titleLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试";
    _desLabel.text = @"开奖时间：2019年11月11日 11:11";
    _subLabel.text = @"我的幸运号码：wu";
}

@end

@interface THWDDB2TableViewCell() {
    UIButton *_receiveButton;
    UILabel *_subLabel;
}

@end

@implementation THWDDB2TableViewCell

- (void)setup {
    [super setup];
    _receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_receiveButton addTarget:self action:@selector(receiveHandler) forControlEvents:UIControlEventTouchUpInside];
    _receiveButton.backgroundColor = UIColorHex(0xFF3C00);
    [_receiveButton setTitle:@"立即领取" forState:UIControlStateNormal];
    [_receiveButton setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
    _receiveButton.titleLabel.font = [UIFont systemFontOfSize:12];
    _receiveButton.layer.masksToBounds = YES;
    _receiveButton.layer.cornerRadius = 25 / 2.0;
    [_containerView addSubview:_receiveButton];
    [_receiveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 25));
        make.right.bottom.equalTo(@(-16));
    }];
}

- (void)settext {
    [super settext];
}

- (void)receiveHandler {
    
}

@end
