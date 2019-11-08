//
//  THSpellGroupHeadCell.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupHeadCell.h"
#import "MLLabel.h"


@implementation THSpellModel

- (instancetype)initWithTime:(NSString *)time state:(NSString *)state validate:(BOOL)validate {
    if (self = [super init]) {
        _time = time;
        _status = state;
        _validate = validate;
    }
    return self;
}

@end



@interface THSpellGroupHeadCell() {
    __weak IBOutlet UILabel *timeLabel;
    __weak IBOutlet MLLabel *statusLabel;
    
}

@end

@implementation THSpellGroupHeadCell 

- (void)refreshWithModel:(THSpellModel *)model {
    timeLabel.text = model.time;
    statusLabel.text = model.status;
    if (!model.validate) {
        timeLabel.textColor = UIColorHex(0x717171);
        statusLabel.textColor = UIColorHex(0x717171);
        statusLabel.backgroundColor = [UIColor clearColor];
    } else {
        timeLabel.textColor = UIColorHex(0xEA2018);
        statusLabel.textColor = UIColorHex(0xffffff);
        statusLabel.backgroundColor = UIColorHex(0xFF3C00);
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    timeLabel.font = [UIFont boldSystemFontOfSize:20];
    statusLabel.font = Font(12);
    self.backgroundColor = UIColorHex(0xffffff);
    statusLabel.layer.masksToBounds = YES;
    statusLabel.layer.cornerRadius = 10.5;
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textInsets = UIEdgeInsetsMake(0, 8, 0, 8);
}

@end
