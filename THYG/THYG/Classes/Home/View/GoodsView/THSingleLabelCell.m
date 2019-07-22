//
//  THSingleLabelCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSingleLabelCell.h"

@implementation THSingleLabelCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;
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
