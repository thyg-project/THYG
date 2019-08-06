//
//  THChangeCountView.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THChangeCountView.h"

@implementation THChangeCountView

- (instancetype)initWithFrame:(CGRect)frame chooseCount:(NSInteger)chooseCount totalCount:(NSInteger)totalCount {
    self = [super initWithFrame:frame];
    if (self) {
        self.choosedCount = chooseCount;
        self.totalCount = totalCount;
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_normal"] forState:UIControlStateNormal];
    [_subButton setBackgroundImage:[UIImage imageNamed:@"product_detail_sub_no"] forState:UIControlStateDisabled];
    _subButton.exclusiveTouch = YES;
    _subButton.backgroundColor = [UIColor clearColor];
    [self addSubview:_subButton];
    [_subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
    }];
    if (self.choosedCount <= 1) {
        _subButton.enabled = NO;
    }else{
        _subButton.enabled = YES;
    }
    
    _numberFD = [[UITextField alloc]initWithFrame:CGRectZero];
    _numberFD.textAlignment=NSTextAlignmentCenter;
    _numberFD.keyboardType=UIKeyboardTypeNumberPad;
    _numberFD.clipsToBounds = YES;
    _numberFD.layer.borderColor = [RGB(221,221,221) CGColor];
    _numberFD.layer.borderWidth = 0.5;
    _numberFD.textColor = RGB(81,81,81);
    _numberFD.font = [UIFont systemFontOfSize:13];
    _numberFD.backgroundColor = [UIColor whiteColor];
    _numberFD.text = [NSString stringWithFormat:@"%zi",self.choosedCount];
    [self addSubview:_numberFD];
    [_numberFD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.equalTo(_subButton);
        make.left.equalTo(_subButton.mas_right);
        make.width.mas_equalTo(40);
    }];
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.backgroundColor = [UIColor clearColor];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_normal"] forState:UIControlStateNormal];
    [_addButton setBackgroundImage:[UIImage imageNamed:@"product_detail_add_no"] forState:UIControlStateDisabled];
    _addButton.exclusiveTouch = YES;
    [self addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(_numberFD.mas_right);
    }];
    if (self.choosedCount >= self.totalCount) {
        _addButton.enabled = NO;
    }else{
        _addButton.enabled = YES;
    }
    
}

@end
