//
//  THPLTGCollectionViewCell.m
//  THYG
//
//  Created by C on 2019/11/9.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THPLTGCollectionViewCell.h"

@interface THPLTGCollectionViewCell() {
    UIImageView *_imageView;
    UILabel *_nameLabel;
    UILabel *_pLabel;
    UILabel *_desLabel;
}

@end

@implementation THPLTGCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorHex(0xffffff);
        [self setup];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 6;
    }
    return self;
}

- (void)setup {
    _imageView = [UIImageView new];
    _imageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_imageView];
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = UIColorHex(0x717171);
    _nameLabel.numberOfLines = 2;
    [self.contentView addSubview:_nameLabel];
    _pLabel = [UILabel new];
    _pLabel.textColor = UIColorHex(0xFF3C00);
    _pLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_pLabel];
    _desLabel = [UILabel new];
    _desLabel.textAlignment = NSTextAlignmentRight;
    _desLabel.font = [UIFont systemFontOfSize:9];
    _desLabel.textColor = UIColorHex(0x989898);
    [self.contentView addSubview:_desLabel];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.mas_equalTo(WIDTH(175));
    }];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@(-8));
        make.top.equalTo(_imageView.mas_bottom).offset(8);
    }];
    
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(@(-8));
        make.height.mas_equalTo(14);
    }];
    [_pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.bottom.equalTo(_desLabel);
        make.right.equalTo(_desLabel.mas_left).offset(-8);
    }];
    _nameLabel.text = @"ceshiceshiceshiceshiceshiceshiceshiceshiceshi";
    _pLabel.text = @"¥ 27.01";
    _desLabel.text = @"已售1.4万件";
}

@end
