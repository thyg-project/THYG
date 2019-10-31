//
//  THCardEmptyView.m
//  THYG
//
//  Created by C on 2019/10/29.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCardEmptyView.h"

@implementation THCardEmptyView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"购物车空状态"]];
    [self addSubview:imageView];
    UILabel *emptyLabel = [UILabel new];
    emptyLabel.textColor = UIColorHex(0x717171);
    emptyLabel.font = [UIFont systemFontOfSize:16];
    emptyLabel.text = @"购物车竟然空的";
    [self addSubview:emptyLabel];
    UILabel *desLabel = [UILabel new];
    desLabel.text = @"是时候买点东西好好犒劳一下自己了~";
    desLabel.textColor = UIColorHex(0x989898);
    desLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:desLabel];
    UIButton *goOther = [UIButton buttonWithType:UIButtonTypeCustom];
    goOther.titleLabel.font = [UIFont systemFontOfSize:16];
    [goOther setTitleColor:UIColorHex(0x717171) forState:UIControlStateNormal];
    goOther.adjustsImageWhenHighlighted = YES;
    [goOther setTitle:@"去逛逛" forState:UIControlStateNormal];
    goOther.layer.borderColor = UIColorHex(0x989898).CGColor;
    goOther.layer.borderWidth = .5;
    [goOther addTarget:self action:@selector(gotoOther) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:goOther];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(160, 160));
        make.top.equalTo(@16);
    }];
    [emptyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(imageView.mas_bottom);
    }];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(emptyLabel.mas_bottom).offset(8);
    }];
    [goOther mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imageView);
        make.top.equalTo(desLabel.mas_bottom).offset(16);
        make.size.mas_equalTo(CGSizeMake(64, 34));
    }];
}

- (void)gotoOther {
    BLOCK(self.toOther);
}

@end
