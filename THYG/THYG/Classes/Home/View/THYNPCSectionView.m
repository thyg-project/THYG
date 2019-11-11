//
//  THYNPCSectionView.m
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THYNPCSectionView.h"
#import "THButton.h"

@interface THYNPCSectionView()

@end

@implementation THYNPCSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorHex(0xffffff);
        [self setup];
    }
    return self;
}

- (void)setup {
    NSArray *array = @[@"综合",@"销量",@"筛选"];
    
    for (int i = 0; i < array.count; i ++) {
        THButton *button = [THButton buttonWithType:i == 1 ? THButtonType_Text : THButtonType_imageRight];
        [button addTarget:self action:@selector(buttonClick:)];
        button.title = array[i];
        button.tag = i;
        [self addSubview:button];
        button.font = [UIFont systemFontOfSize:16];
        button.textColor = UIColorHex(0x989898);
        if (i == 0) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@16);
                make.top.bottom.equalTo(self);
            }];
        } else if (i == 1) {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(self);
            }];
        } else {
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(@(-16));
                make.top.bottom.equalTo(self);
                make.width.mas_equalTo(60);
            }];
        }
        
    }
}


- (void)buttonClick:(THButton *)button {
    BLOCK(self.selectHandler,button.tag);
}

@end
