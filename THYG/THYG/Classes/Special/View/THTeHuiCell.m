//
//  THTeHuiCell.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCell.h"
#import "THTeHuiModel.h"



@interface THTeHuiCell () {
    
}

@end

@implementation THTeHuiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    
}

- (void)setCommonModel:(THTeHuiModel *)commonModel {
    _commonModel = commonModel;
}


@end
