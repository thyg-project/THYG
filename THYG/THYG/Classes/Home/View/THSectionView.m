//
//  THSectionView.m
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THSectionView.h"
#import "UIView+Corner.h"

@interface THSectionView(){
    UIView *_containerView;
    UILabel *_leftLabel, *_rightLabel;
}

@end

@implementation THSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        [self setup];
    }
    return self;
}

- (void)setup {
    _containerView = [UIView new];
    _containerView.backgroundColor = UIColorHex(0xffffff);
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
    }];
    _leftLabel = [UILabel new];
    
    _leftLabel.font = [UIFont systemFontOfSize:16];
    _leftLabel.textColor = UIColorHex(0x121212);
    _leftLabel.text = @"t测试";
    _rightLabel = [UILabel new];
    
    
    _rightLabel.textColor = UIColorHex(0x989898);
    _rightLabel.font = [UIFont systemFontOfSize:12];
    _rightLabel.text = @"更多商品活动  >";
    [_containerView addSubview:_leftLabel];
    [_containerView addSubview:_rightLabel];
    [_leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.bottom.equalTo(self);
    }];
    [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.top.bottom.equalTo(_leftLabel);
    }];
    [_rightLabel addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(more)];
        tap;
    })];
}


- (void)more {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_containerView setCornerRadius:16 inCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
    
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = ColorWithHex(0x989898, .1).CGColor;
    layer.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 1, CGRectGetWidth(self.frame), 1);
    [_containerView.layer addSublayer:layer];
}


@end


@interface THSectionFooter(){
    UIView *_topView;
}

@end

@implementation THSectionFooter
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColor.clearColor;
        _topView = [UIView new];
        _topView.backgroundColor = UIColorHex(0xffffff);
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.right.equalTo(@(-16));
            make.top.equalTo(@(-8));
            make.height.mas_equalTo(16);
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_topView setCornerRadius:16 inCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
}

@end
