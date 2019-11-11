//
//  THCardSectionHeader.m
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCardSectionHeader.h"

@interface THCardSectionHeader() {
    UIButton *_selectedButton;
    UILabel *_titleLabel;
    UIView *_containerView;
}

@end

@implementation THCardSectionHeader

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self setup];
    }
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
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
        make.left.equalTo(@(16));
        make.right.equalTo(@(-16));
    }];
    
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectedButton.adjustsImageWhenHighlighted = YES;
    [_selectedButton setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
    [_selectedButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_selectedButton];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"发货人发货人";
    _titleLabel.textColor = UIColorHex(0x121212);
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [_containerView addSubview:_titleLabel];
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(@12);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(_selectedButton.mas_right).offset(12);
    }];
    
}


- (void)buttonClick {
    _selectedButton.selected = !_selectedButton.selected;
    BLOCK(self.SelectedBlock,_selectedButton.selected);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_containerView setCornerRadius:8 inCorners:UIRectCornerTopLeft|UIRectCornerTopRight];
}

@end
