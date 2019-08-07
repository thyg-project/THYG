//
//  THSingleLabelCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSingleLabelCell.h"

@implementation THSingleLabelCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        _singleLabel = [UILabel new];
        _singleLabel.textAlignment = NSTextAlignmentCenter;
        _singleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.singleLabel];
        [self.singleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    if (_isSelected) {
        self.contentView.backgroundColor = RGB(213, 0, 27);
        self.singleLabel.textColor = [UIColor whiteColor];
    }else{
        self.contentView.backgroundColor = RGB(234, 234, 234);
        self.singleLabel.textColor = RGB(66, 66, 66);
    }
}

@end
