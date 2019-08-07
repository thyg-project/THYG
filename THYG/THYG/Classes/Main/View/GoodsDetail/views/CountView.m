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
@synthesize addButton,reduceButton,countTextField,label;
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        label = nil;
        label.text = @"购买数量";
        label.font = [UIFont systemFontOfSize:14];
        [self addSubview:label];
        
        
        [self addSubview:addButton];
       
        countTextField = nil;
        countTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        [self addSubview:countTextField];
        
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        
        _textFieldDownButton= nil;
        _textFieldDownButton.frame = CGRectMake(kScreenWidth-50, 0, 50, 40);
        [view addSubview:_textFieldDownButton];
        countTextField.inputAccessoryView = view;
        
        reduceButton= nil;
        
        [self addSubview:reduceButton];
        
      
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
