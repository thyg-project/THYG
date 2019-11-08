//
//  THTeTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTeTableViewCell.h"





@implementation THTeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = UIColorHex(0xf7f8f9);
        [self setup];
    }
    return self;
}

- (void)setup {
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(@(16));
        make.right.equalTo(@(-16));
    }];
    _leftImageView = [UIImageView new];
    _leftImageView.backgroundColor = [UIColor yellowColor];
    [_containerView addSubview:_leftImageView];
    _titleLabel = [UILabel new];
    _titleLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试";
    _titleLabel.textColor = UIColorHex(0x717171);
    _titleLabel.numberOfLines = 2;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [_containerView addSubview:_titleLabel];
    _desLabel = [UILabel new];
    [_containerView addSubview:_desLabel];
    [_leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.size.mas_equalTo(CGSizeMake(96, 96));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.right.equalTo(@(-16));
        make.top.equalTo(_leftImageView);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end


@interface THTeDBTableViewCell() {
   
}

@end

@implementation THTeDBTableViewCell

- (void)setup {
    [super setup];
    _desLabel.textColor = UIColorHex(0x989898);
    _desLabel.font = [UIFont systemFontOfSize:12];
    _desLabel.text = @"揭晓进度84%";
    _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.layer.masksToBounds = YES;
    _progressView.layer.cornerRadius = 2;
    _progressView.progressTintColor = UIColorHex(0xE81D19);
    _progressView.trackTintColor = UIColorHex(0xf1f1f1);
    _progressView.progress = .5;
    [_containerView addSubview:_progressView];
    _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buyButton setTitle:@"立即夺宝" forState:UIControlStateNormal];
    _buyButton.backgroundColor = UIColorHex(0xE81D19);
    _buyButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [_buyButton setTitleColor:UIColorHex(0xffffff) forState:UIControlStateNormal];
    _buyButton.layer.masksToBounds = YES;
    _buyButton.layer.cornerRadius = WIDTH(30) / 2.0;
    [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:_buyButton];
    [_buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-8));
        make.right.equalTo(@(-16));
        make.size.mas_equalTo(CGSizeMake(WIDTH(96), WIDTH(30)));
    }];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_leftImageView.mas_right).offset(8);
        make.right.equalTo(_buyButton.mas_left).offset(-8);
        make.bottom.equalTo(_buyButton);
        make.height.mas_equalTo(4);
    }];
    [self->_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_progressView);
        make.bottom.equalTo(_progressView.mas_top).offset(-4);
    }];
}

- (void)buy {
    
}

@end

@interface THTePTableViewCell() {
    UILabel *_pLabel;
}

@end


@implementation THTePTableViewCell

- (void)setup {
    [super setup];
    _desLabel.textColor = UIColorHex(0xffffff);
    _desLabel.font = [UIFont systemFontOfSize:9];
    _desLabel.layer.masksToBounds = YES;
    _desLabel.text = @"200特币抵扣¥20";
    _desLabel.textAlignment = NSTextAlignmentCenter;
    _desLabel.layer.cornerRadius = 3;
    _desLabel.backgroundColor = UIColorHex(0xFF3C00);
    _pLabel = [UILabel new];
    [_containerView addSubview:_pLabel];
    [_pLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-8));
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.right.equalTo(_titleLabel);
        make.height.mas_equalTo(33);
    }];
    [_desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(82, 14));
        make.left.equalTo(_pLabel);
        make.bottom.equalTo(_pLabel.mas_top).offset(-4);
    }];
    [self settest];
}

- (void)settest {
    NSString *string = @"¥ 13.8  ¥ 33.8";
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:UIColorHex(0xD62326)} range:[string rangeOfString:@"¥ 13.8"]];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:UIColorHex(0x989898),NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:NSUnderlinePatternSolid | NSUnderlineStyleSingle]} range:[string rangeOfString:@"¥ 33.8"]];
    [_pLabel setAttributedText:att];
    
    
}

@end
