//
//  THTeMoneyHead.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeMoneyHead.h"

@interface THTeMoneyHead() {
    UIImageView *_bgImageView, *_avaImageView;
    UILabel *_coinLabel, *_desLabel;
}


@end

@implementation THTeMoneyHead

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    _bgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"beijing"]];
    [self addSubview:_bgImageView];
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _avaImageView = [[UIImageView alloc] init];
    _avaImageView.image = [UIImage imageNamed:@"touxiang"];
    _avaImageView.layer.cornerRadius = 25;
    [self addSubview:_avaImageView];
    [_avaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self).offset(-10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    _coinLabel = [UILabel new];
    _coinLabel.text = @"888特币";
    _coinLabel.textColor = [UIColor whiteColor];
    _coinLabel.font = [UIFont systemFontOfSize:12];
    _coinLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_coinLabel];
    [_coinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_avaImageView.mas_bottom).offset(8);
    }];
    _desLabel = [UILabel new];
    _desLabel.text = @"为您节省100元";
    _desLabel.textColor = [UIColor whiteColor];
    _desLabel.font = [UIFont systemFontOfSize:12];
    _desLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_desLabel];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.equalTo(@42);
        make.bottom.equalTo(self);
    }];
}


@end
