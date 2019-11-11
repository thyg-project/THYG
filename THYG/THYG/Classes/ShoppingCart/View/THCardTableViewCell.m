//
//  THCardTableViewCell.m
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCardTableViewCell.h"
#import "THChangeCountView.h"

@interface THCardContentLabel : UIView {
    UILabel *_contentLabel;
    UIButton *_arrowButton;
}

@property (nonatomic, copy) void (^(ButtonClick))(BOOL hidden);

@end

@implementation THCardContentLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _contentLabel = [UILabel new];
    _contentLabel.text = @"产品属性产品属性产品属性产品属产品属性产品属";
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = UIColorHex(0x989898);
    _contentLabel.numberOfLines = 2;
    [self addSubview:_contentLabel];
    _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _arrowButton.adjustsImageWhenHighlighted = YES;
    [_arrowButton setImage:[UIImage imageNamed:@"下.png"] forState:UIControlStateNormal];
    [_arrowButton setImage:[UIImage imageNamed:@"下.png"] forState:UIControlStateSelected];
    [_arrowButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_arrowButton];
    [_arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@(-15));
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(@(8));
        make.right.equalTo(_arrowButton.mas_left).offset(-5);
    }];
    
}

- (void)buttonClick {
    _arrowButton.selected = !_arrowButton.selected;
    BLOCK(self.ButtonClick,_arrowButton.selected);
}

@end

@interface THCardTableViewCell() {
    UIView *_containerView;
    UIButton *_selectedButton;
    UIImageView *_contentImageView;
    UILabel *_titleLabel;
    THCardContentLabel *_contentLabel;
    UILabel *_priceLabel;
    THChangeCountView *_countView;
}

@end

@implementation THCardTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = kBackgroundColor;
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
    
    
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.layer.masksToBounds = YES;
    _contentImageView.layer.cornerRadius = 2;
    _contentImageView.backgroundColor = UIColor.redColor;
    [_containerView addSubview:_contentImageView];
    _selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_selectedButton setImage:[UIImage imageNamed:@"未选中.png"] forState:UIControlStateNormal];
    [_selectedButton setImage:[UIImage imageNamed:@"选中.png"] forState:UIControlStateSelected];
    [_selectedButton addTarget:self action:@selector(selectedButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_selectedButton];
    _titleLabel = [UILabel new];
    _titleLabel.numberOfLines = 2;
    _titleLabel.text = @"产品名产品名产品名产品名产品名产品产品名产品名产品名产品名";
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = UIColorHex(0x121212);
    [_containerView addSubview:_titleLabel];
    _contentLabel = [THCardContentLabel new];
    [_containerView addSubview:_contentLabel];
    _priceLabel = [UILabel new];
    _priceLabel.text = @"¥560";
    _priceLabel.font = [UIFont systemFontOfSize:12];
    _priceLabel.textColor = UIColorHex(0xD62326);
    [_containerView addSubview:_priceLabel];
    _countView = [THChangeCountView new];
    _countView.ChangedBlock = self.changedBlock;
    [_containerView addSubview:_countView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.equalTo(@44);
        make.size.mas_equalTo(CGSizeMake(82, 82));
    }];
    [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_contentImageView.mas_centerY);
        make.right.equalTo(_contentImageView.mas_left).offset(-12);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@9);
        make.right.equalTo(@(-16));
        make.left.equalTo(_contentImageView.mas_right).offset(16);
        make.height.mas_equalTo(34);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_titleLabel);
        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        make.height.mas_equalTo(42);
    }];
    [_countView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.size.mas_equalTo(CGSizeMake(90, 22));
        make.top.equalTo(_contentLabel.mas_bottom).offset(16);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_countView);
        make.left.equalTo(_contentLabel);
        make.right.equalTo(_countView.mas_left);
    }];
    
}

- (void)selectedButtonClick {
    BLOCK(self.showProductDetail, _selectedButton.selected);
    _selectedButton.selected = !_selectedButton.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setProductDidSeledted:(BOOL)productDidSeledted {
    _productDidSeledted = productDidSeledted;
    _selectedButton.selected = _productDidSeledted;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_containerView setCornerRadius:8 inCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight];
}


@end
