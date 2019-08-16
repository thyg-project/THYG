//
//  THHomeSectionHead.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeSectionHead.h"

@interface THHomeSectionHead() {
    UILabel *_contentLabel;
}

@end

@implementation THHomeSectionHead

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _contentLabel = [UILabel new];
        _contentLabel.font = [UIFont systemFontOfSize:15];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
        _contentLabel.text = @"猜你喜欢";
        [self addSubview:_contentLabel];
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}








@end
