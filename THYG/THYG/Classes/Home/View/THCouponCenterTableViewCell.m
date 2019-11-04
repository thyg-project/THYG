//
//  THCouponCenterTableViewCell.m
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCouponCenterTableViewCell.h"

@interface THCouponCenterTableViewCell() {
    UIImageView *_leftImageView;
    UILabel *_amountLabel, *_desLabel, *_timeLabel;
    UIButton *_button;
}

@end

@implementation THCouponCenterTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup {
    
}


@end
