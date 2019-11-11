//
//  THHomeMallActivityItemCell.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeMallActivityItemCell.h"

@interface THHomeMallActivityItemCell ()

@property (nonatomic, strong) UIImageView *leftImgView;
@property (nonatomic, strong) UIImageView *rightImgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation THHomeMallActivityItemCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setupUI];
	}
	return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = UIColorHex(0xffffff);
	[self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
	[self.contentView addSubview:self.leftImgView];
	[self.contentView addSubview:self.rightImgView];
}

- (void)setItemType:(ActivityItemCellType)itemType {
	_itemType = itemType;
//	self.timeView.hidden = itemType ? YES : NO;
//	self.subLabel.hidden = !itemType ? YES : NO;
}

- (void)setActivityModel:(THHomeActivityModel *)activityModel {
    _activityModel = activityModel;
    self.titleLabel.text = _activityModel.title;
    self.subTitleLabel.text = _activityModel.des;
    self.leftImgView.image = [UIImage imageNamed:_activityModel.leftImage];
    self.rightImgView.image = [UIImage imageNamed:_activityModel.rightImage];
    self.subTitleLabel.textColor = UIColorHex(_activityModel.desColor);
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(@12);
		make.top.equalTo(@8);
	}];
	
	[self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom);
		make.left.equalTo(self.titleLabel.mas_left);
	}];
	
	[self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.subTitleLabel.mas_bottom).offset(4);
        make.left.equalTo(self.subTitleLabel);
        make.size.mas_equalTo(CGSizeMake(WIDTH(68), WIDTH(68)));
	}];
	
	[self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.leftImgView);
		make.right.equalTo(self.mas_right).offset(-12);
        make.size.equalTo(self.leftImgView);
	}];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [THUIFactory labelWithText:@"" fontSize:12 tintColor:UIColorHex(0x222222)];
    }
    return _titleLabel;
}

- (UIImageView *)leftImgView {
	if (!_leftImgView) {
		_leftImgView = [[UIImageView alloc] init];
        _leftImgView.backgroundColor = [UIColor yellowColor];
	}
	return _leftImgView;
}

- (UIImageView *)rightImgView {
	if (!_rightImgView) {
		_rightImgView = [[UIImageView alloc] init];
        _rightImgView.backgroundColor = UIColor.redColor;
	}
	return _rightImgView;
}

- (UILabel *)subTitleLabel {
	if (!_subTitleLabel) {
		_subTitleLabel = [THUIFactory labelWithText:@"" fontSize:12 tintColor:RGB(151,151,151)];
	}
	return _subTitleLabel;
}

@end
