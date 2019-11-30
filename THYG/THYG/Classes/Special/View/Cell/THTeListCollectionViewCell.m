//
//  THTeListCollectionViewCell.m
//  THYG
//
//  Created by C on 2019/11/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTeListCollectionViewCell.h"

@interface THTeListCollectionViewCell() {
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_productLabel;
    UIButton *_likeButton;
    UIImageView *_avaImageView;
}

@end

@implementation THTeListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _imageView = [UIImageView new];
    [self addSubview:_imageView];
    _nameLabel = [UILabel new];
    [self addSubview:_nameLabel];
    _productLabel = [UILabel new];
    [self addSubview:_productLabel];
    _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:_likeButton];
    _avaImageView = [UIImageView new];
    [self addSubview:_avaImageView];
    [_avaImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.left.equalTo(@8);
        make.bottom.equalTo(@(-8));
    }];
    [_likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-8));
        make.centerY.equalTo(_avaImageView);
        make.width.mas_equalTo(45);
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_avaImageView);
        make.left.equalTo(_avaImageView.mas_right).offset(4);
        make.right.equalTo(_likeButton.mas_left);
    }];
    [_productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_avaImageView);
        make.right.equalTo(_likeButton);
        make.bottom.equalTo(_likeButton.mas_top).offset(-8);
        make.height.mas_equalTo(22);
    }];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.bottom.equalTo(_productLabel.mas_top).offset(-8);
    }];
}

@end
