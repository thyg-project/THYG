//
//  THFilterView.m
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THFilterView.h"

@interface THFilterView() {
    NSArray <NSString *> *_normalDatas;
    
    
}

@end


@implementation THFilterView

- (instancetype)initWithDatas:(NSArray <NSString *>*)datas {
    if (self = [super init]) {
        _normalDatas = datas.mutableCopy;
        [self initinalizedView];
    }
    return self;
}

- (void)initinalizedView {
    if (!YGInfo.validArray(_normalDatas)) {
        return;
    }
    NSMutableArray *buttons = [NSMutableArray new];
    for (NSInteger i = 0; i < _normalDatas.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitle:_normalDatas[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(topViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [buttons addObject:btn];
    }
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
}

- (void)setNormalTitles:(NSArray<NSString *> *)normalTitles {
    _normalDatas = normalTitles.mutableCopy;
    [self clear];
    [self initinalizedView];
}

- (void)setSelectedTitles:(NSArray<NSString *> *)selectedTitles {
    if (!YGInfo.validArray(selectedTitles)) {
        return;
    }
    for (int i = 0; i < selectedTitles.count; i ++) {
        UIView *view = [self viewWithTag:i];
        if ([view isKindOfClass:[UIButton class]]) {
            [((UIButton *)view) setTitle:selectedTitles[i] forState:UIControlStateSelected];
        }
    }
}

- (void)setNormalColor:(UIColor *)normalColor {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:normalColor forState:UIControlStateNormal];
        }
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            [button setTitleColor:selectedColor forState:UIControlStateSelected];
        }
    }
}

- (void)setFont:(UIFont *)font {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.titleLabel.font = font;
        }
    }
}

- (void)topViewClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(filterView:disSelectedItem:selectedIndex:)]) {
        [self.delegate filterView:self disSelectedItem:_normalDatas[sender.tag] selectedIndex:sender.tag];
    }
}

- (void)clear {
    [self removeAllSubviews];
}

@end