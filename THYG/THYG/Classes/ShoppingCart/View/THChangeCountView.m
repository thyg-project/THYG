//
//  THChangeCountView.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THChangeCountView.h"

@interface THChangeCountView()
//加
@property (nonatomic, strong) UIButton *addButton;
//减
@property (nonatomic, strong) UIButton *subButton;
//数字按钮
@property (nonatomic, strong) UITextField  *numberFD;


@end

@implementation THChangeCountView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    _numberFD = [[UITextField alloc]initWithFrame:CGRectZero];
    _numberFD.textAlignment=NSTextAlignmentCenter;
    _numberFD.keyboardType=UIKeyboardTypeNumberPad;
    _numberFD.clipsToBounds = YES;
    _numberFD.layer.borderColor = [UIColorHex(0x989898) CGColor];
    _numberFD.layer.borderWidth = 0.5;
    _numberFD.layer.cornerRadius = 3;
    _numberFD.enabled = NO;
    _numberFD.textColor = UIColorHex(0x121212);
    _numberFD.font = [UIFont systemFontOfSize:13];
    _numberFD.backgroundColor = [UIColor whiteColor];
    _numberFD.text = @"0";
    _numberFD.rightViewMode = UITextFieldViewModeAlways;
    _numberFD.leftViewMode = UITextFieldViewModeAlways;
    [self addSubview:_numberFD];
    [_numberFD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _subButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_subButton setTitle:@"-" forState:UIControlStateNormal];
    _subButton.exclusiveTouch = YES;
    _subButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_subButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_subButton setTitleColor:UIColorHex(0x989898) forState:UIControlStateNormal];
    _subButton.backgroundColor = [UIColor clearColor];
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 22)];
    [leftView addSubview:_subButton];
    [_subButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(leftView);
    }];
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 25, 22)];
    _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.backgroundColor = [UIColor clearColor];
    _addButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [_addButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [_addButton setTitleColor:UIColorHex(0x989898) forState:UIControlStateNormal];
    [_addButton setTitle:@"+" forState:UIControlStateNormal];
    _addButton.exclusiveTouch = YES;
    [rightView addSubview:_addButton];
    [_addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rightView);
    }];
    
    _numberFD.leftView = leftView;
    _numberFD.rightView = rightView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CALayer *leftLayer = [CALayer layer];
    leftLayer.frame = CGRectMake(25, 0, 0.5, 22);
    leftLayer.backgroundColor = UIColorHex(0x989898).CGColor;
    [self.layer addSublayer:leftLayer];
    CALayer *rightLayer = [CALayer layer];
    rightLayer.frame = CGRectMake(CGRectGetWidth(_numberFD.frame) - 25, 0, 0.5, 22);
    rightLayer.backgroundColor = UIColorHex(0x989898).CGColor;
    [self.layer addSublayer:rightLayer];
    
}

- (void)buttonClick:(UIButton *)sender {
    if (sender == _subButton) {
        BLOCK(self.ChangedBlock,YES);
    } else {
        BLOCK(self.ChangedBlock,NO);
    }
}


- (void)setContent:(NSString *)content {
    _numberFD.text = content;
}

@end
