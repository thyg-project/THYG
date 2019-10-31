//
//  THMyOrderView.m
//  THYG
//
//  Created by C on 2019/10/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THMyOrderView.h"
#import "THButton.h"

@interface THMyOrderView() {
    NSArray <NSString *> *_titles;
}

@end

@implementation THMyOrderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 16;
        [self setup];
    }
    return self;
}

- (void)setup {
    _titles = @[@"待付款",@"待收货",@"待评价",@"退换货"];
    NSMutableArray <THButton *> *buttons = [NSMutableArray new];
    for (int i = 0; i < _titles.count; i ++) {
        THButton *button = [THButton buttonWithType:THButtonType_imageTop];
        button.image = [UIImage imageNamed:[_titles[i] stringByAppendingString:@".png"]];
        button.title = _titles[i];
        button.font = [UIFont systemFontOfSize:12];
        button.textColor = UIColorHex(0x121212);
        button.margen = 6;
        button.tag = i + 1;
        [button addTarget:self action:@selector(buttonClick:)];
        [self addSubview:button];
        [buttons addObject:button];
    }
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:12 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-16));
        make.top.equalTo(@50);
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"我的订单";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = UIColorHex(0x121212);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.equalTo(@16);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *desLabel = [UILabel new];
    desLabel.font = [UIFont systemFontOfSize:12];
    desLabel.textColor = UIColorHex(0x989898);
    desLabel.text = @"查看全部订单  >";
    [desLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(allOrder)]];
    [self addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.centerY.equalTo(titleLabel);
    }];
    UIView *line = [UIView new];
    
    line.backgroundColor = ColorWithHex(0x989898,.1);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(@38);
    }];
}

- (void)buttonClick:(THButton *)sender {
    if ([self.delegate respondsToSelector:@selector(orderView:didClickState:)]) {
        [self.delegate orderView:self didClickState:sender.tag];
    }
}

- (void)allOrder {
    if ([self.delegate respondsToSelector:@selector(orderView:didClickState:)]) {
        [self.delegate orderView:self didClickState:THOrderState_All];
    }
}

@end
