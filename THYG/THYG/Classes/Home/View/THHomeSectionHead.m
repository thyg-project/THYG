//
//  THHomeSectionHead.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeSectionHead.h"
#import "UIView+Corner.h"

@interface THHomeSectionHead() {
    UILabel *_contentLabel;
}

@end

@implementation THHomeSectionHead

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = @"每日推荐";
        _contentLabel.backgroundColor = UIColorHex(0xffffff);
        _contentLabel.textColor = UIColorHex(0xD62326);
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(@8);
            make.right.equalTo(@(-8));
        }];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [_contentLabel setCornerRadius:8 inCorners:UIRectCornerTopLeft | UIRectCornerTopRight];
}






@end
