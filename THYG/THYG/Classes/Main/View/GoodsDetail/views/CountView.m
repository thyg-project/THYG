//
//  CountView.m
//  MeiXiangDao_iOS
//
//  Created by 澜海利奥 on 2017/9/26.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import "CountView.h"
#import "GoodsModel.h"
@implementation CountView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [UILabel new];
        _label.text = @"购买数量";
        _label.font = [UIFont systemFontOfSize:14];
        [self addSubview:_label];
        _addButton = [THUIFactory buttonWithImage:@"" selectedImage:@"" target:self action:@selector(addAction)];
        
        [self addSubview:_addButton];
       
        _countTextField = [UITextField new];
        _countTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:_countTextField];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        
        _textFieldDownButton = [THUIFactory buttonWithImage:@"" selectedImage:@"" target:self action:@selector(downAction)];
        [view addSubview:_textFieldDownButton];
        _countTextField.inputAccessoryView = view;
        
        _reduceButton = [THUIFactory buttonWithImage:@"" selectedImage:@"" target:self action:@selector(reduceAction)];
        
        [self addSubview:_reduceButton];
        
        [self layoutViews];
    }
    return self;
}

- (void)layoutViews {
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.textFieldDownButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    [self.countTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
}

- (void)downAction {
    
}

- (void)reduceAction {
    
}

- (void)addAction {
    
}


@end
