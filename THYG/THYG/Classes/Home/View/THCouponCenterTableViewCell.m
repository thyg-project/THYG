//
//  THCouponCenterTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCouponCenterTableViewCell.h"
#import "UIImage+CHImage.h"


@interface THCouponCenterTableViewCell() {
    UIImageView *_leftImageView;
    UILabel *_amountLabel, *_desLabel, *_timeLabel;
    UIButton *_button;
}

@end

@implementation THCouponCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup {
    _leftImageView = [[UIImageView alloc] init];
    [self addSubview:_leftImageView];
    _amountLabel = [UILabel new];
    _amountLabel.font = [UIFont systemFontOfSize:24];
    _amountLabel.textColor = UIColorHex(0xff3c00);
    [self addSubview:_amountLabel];
    _desLabel = [UILabel new];
    _desLabel.textColor = UIColorHex(0x717171);
    _desLabel.font = [UIFont systemFontOfSize:12];
    _desLabel.numberOfLines = 2;
    [self addSubview:_desLabel];
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:9];
    _timeLabel.textColor = UIColorHex(0x989898);
    [self addSubview:_timeLabel];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setBackgroundImage:[UIImage drawImageWithStartColor:UIColorHex(0xFA8F1D) endColor:UIColorHex(0xFF3C00) bounds:CGRectMake(0, 0, 80, 25) startPoint:CGPointMake(0, 0.5) endPoint:CGPointMake(1, 0.5)] forState:UIControlStateNormal];
    [_button setTitle:@"立即领取" forState:UIControlStateNormal];
    [_button setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont systemFontOfSize:12];
    [_button addTarget:self action:@selector(receive) forControlEvents:UIControlEventTouchUpInside];
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 25.0 / 2;
    [self addSubview:_button];
    [_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@(-10));
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
    
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@16);
        make.bottom.equalTo(@(-16));
        make.width.mas_equalTo(80);
    }];
    
    [_amountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_leftImageView);
        make.left.equalTo(_leftImageView.mas_right).offset(8);
    }];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-131));
        make.left.equalTo(_amountLabel);
        make.top.equalTo(_amountLabel.mas_bottom).offset(6);
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_leftImageView);
        make.left.equalTo(_amountLabel);
    }];
}

- (void)receive {
    
}

- (void)setCouponModel:(THCouponModel *)couponModel {
    _couponModel = couponModel;
    _leftImageView.backgroundColor = [UIColor redColor];
    NSString *string = [@"¥20" stringByAppendingString:@"满200减20"];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} range:[string rangeOfString:@"满200减20"]];
    _amountLabel.attributedText = att;
    _desLabel.text = @"sjahsjkbdaskjbdfahsjbfaksfabhjkbfaskfd";
    _timeLabel.text = @"2019.09.10 00:00-2020.09.10 00:00";
}


@end
