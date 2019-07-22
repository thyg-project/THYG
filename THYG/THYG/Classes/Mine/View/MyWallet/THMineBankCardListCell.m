//
//  THMineBankCardListCell.m
//  THYG
//
//  Created by Victory on 2018/6/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineBankCardListCell.h"

@implementation THMineBankCardListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor clearColor];
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
