//
//  THTBDBSectionHeader.m
//  THYG
//
//  Created by C on 2019/11/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTBDBSectionHeader.h"
#import "UIView+Corner.h"

@interface THTBDBSectionHeader() {
    UIView *_containerView;
    UILabel *_titleLabel;
}

@end

@implementation THTBDBSectionHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _containerView = [UIView new];
    _containerView.backgroundColor = UIColorHex(0xffffff);
    [self addSubview:_containerView];
    _titleLabel = [UILabel new];
    if (@available(iOS 8.2, *)) {
        _titleLabel.font = [UIFont systemFontOfSize:24 weight:UIFontWeightMedium];
    } else {
        _titleLabel.font = [UIFont systemFontOfSize:24];
    }
    _titleLabel.textColor = UIColorHex(0x121212);
    [_containerView addSubview:_titleLabel];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(@(16));
        make.right.equalTo(@(-16));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_containerView);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_containerView setCornerRadius:16 inCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
}

- (void)setTitle:(NSString *)title {
    _titleLabel.text = title;
}

@end
