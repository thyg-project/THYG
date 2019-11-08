//
//  THSHMSTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THSHMSTableViewCell.h"

@interface THSHMSTableViewCell() {
    UILabel *_priceLabel;
}

@end

@implementation THSHMSTableViewCell

- (void)setup {
    [super setup];
    _priceLabel = [UILabel new];
    [self->_containerView addSubview:_priceLabel];
    [_leftImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@8);
    }];
    [_buyButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-8));
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_titleLabel.mas_bottom).offset(6);
        make.left.equalTo(_leftImageView.mas_right).offset(8);
        make.height.mas_equalTo(33);
    }];
    [self settest];
}

- (void)settest {
    NSString *string = @"¥ 13.8  ¥ 33.8";
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:24],NSForegroundColorAttributeName:UIColorHex(0xD62326)} range:[string rangeOfString:@"¥ 13.8"]];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:UIColorHex(0x989898),NSStrikethroughStyleAttributeName:[NSNumber numberWithInt:NSUnderlinePatternSolid | NSUnderlineStyleSingle]} range:[string rangeOfString:@"¥ 33.8"]];
    [_priceLabel setAttributedText:att];
}

@end
