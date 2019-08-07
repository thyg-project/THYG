//
//  THCommentCateViewCell.m
//  THYG
//
//  Created by 廖辉 on 2018/6/12.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCommentCateViewCell.h"
#import "THButton.h"

@interface THCommentCateViewCell() {
    THButton *_selectedButton;
}

@end

@implementation THCommentCateViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _selectedButton = [THButton buttonWithType:THButtonType_None];
        _selectedButton.title = @"全部";
        _selectedButton.font = [UIFont systemFontOfSize:14];
        _selectedButton.textColor = UIColor.lightGrayColor;
        _selectedButton.selectedTextColor = UIColor.redColor;
        [_selectedButton addTarget:self action:@selector(touchAction)];
        [self.contentView addSubview:_selectedButton];
        [_selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
        _selectedButton.layer.borderColor = UIColor.redColor.CGColor;
        _selectedButton.layer.borderWidth = 1;
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    if (selected) {
        _selectedButton.layer.borderColor = [UIColor redColor].CGColor;
        _selectedButton.layer.borderWidth = 1;
    }else{
        _selectedButton.layer.borderColor = RGB(240,240,240).CGColor;
        _selectedButton.layer.borderWidth = 1;
        
    }
}

- (void)touchAction {
    
    
}

@end
