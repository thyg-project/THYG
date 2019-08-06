//
//  THSpellGroupHeadCell.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupHeadCell.h"


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
    __weak IBOutlet UILabel *statusLabel;
    
}

@end

@implementation THSpellGroupHeadCell 

- (void)refreshWithModel:(THSpellModel *)model {
    timeLabel.text = model.time;
    statusLabel.text = model.status;
    
    if (!model.validate) {
        self.backgroundColor = RGB(200, 200, 200);
        timeLabel.textColor = RGB(81, 81, 81);
        statusLabel.textColor = RGB(81, 81, 81);
        timeLabel.font = Font(14);
        statusLabel.font = Font(13);
    } else { 
        self.backgroundColor = RGB(213, 0, 27);
        timeLabel.textColor = RGB(255, 255, 255);
        statusLabel.textColor = RGB(255, 255, 255);
        timeLabel.font = Font(16);
        statusLabel.font = Font(15);
        
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
