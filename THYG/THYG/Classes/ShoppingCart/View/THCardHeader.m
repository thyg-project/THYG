//
//  THCardHeader.m
//  THYG
//
//  Created by C on 2019/10/28.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCardHeader.h"

@interface THCardHeader() {
    UILabel *_contentLabel;
    UIImageView *_containerImageView;
}

@end

@implementation THCardHeader

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setEmpty:(BOOL)empty {
    _empty = empty;
    _containerImageView.image = [UIImage imageNamed:_empty?@"我的空状态底图.png":@"member-head-bg.png"];
}

- (void)setup {
    UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"我的空状态底图.png"]];
    [self addSubview:containerView];
    _containerImageView = containerView;
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"购物车";
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textColor = UIColorHex(0xffffff);
    [self addSubview:titleLabel];
    _contentLabel = [UILabel new];
    _contentLabel.text = @"共0件宝贝";
    _contentLabel.textColor = UIColorHex(0xffffff);
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_contentLabel];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(10 + kStatesBarHeight));
        make.left.equalTo(@16);
    }];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_bottom).offset(8);
        make.left.equalTo(titleLabel);
    }];
}

- (void)setContent:(NSString *)content {
    _contentLabel.text = content;
}



@end
