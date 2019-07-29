//
//  THFilterView.m
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THFilterView.h"

static NSInteger const kButtonTag = 10086;

@interface THFilterView() {
    NSArray <NSString *> *_normalDatas;
    
    CGFloat _horizontalSpace;
}

@end


@implementation THFilterView

- (instancetype)initWithDatas:(NSArray <NSString *>*)datas {
    return [self initWithDatas:datas horizontalSpace:1];
}

- (instancetype)initWithDatas:(NSArray<NSString *> *)datas horizontalSpace:(CGFloat)horizontalSpace {
    if (self = [super init]) {
        _normalDatas = datas.mutableCopy;
        _horizontalSpace = horizontalSpace;
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
        btn.tag = i + kButtonTag;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn setTitle:_normalDatas[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(topViewClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [buttons addObject:btn];
    }
    [buttons mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:_horizontalSpace leadSpacing:0 tailSpacing:0];
    [buttons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
    }];
}

- (void)setHorizontalSpace:(CGFloat)horizontalSpace {
   
}

- (void)setImageNames:(NSArray<NSString *> *)imageNames {
    for (int i = 0; i < imageNames.count; i ++) {
        UIButton *button = [self viewWithTag:i + kButtonTag];
        if ([button isKindOfClass:[UIButton class]]) {
            [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:imageNames[i]] forState:UIControlStateHighlighted];
        }
    }
}

- (void)setImage:(UIImage *)image selectedImage:(UIImage *)selectedImage index:(NSInteger)index {
    UIButton *button = [self viewWithTag:index + kButtonTag];
    if (!button) {
        return;
    }
    if (image) {
        [button setImage:image forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:selectedImage forState:UIControlStateSelected];
    }
}

- (void)setImageMargenToText:(CGFloat)imageMargenToText {
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]] && button.imageView.image) {
            button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, imageMargenToText);
        }
    }
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]] && button.tag == selectedIndex) {
            button.selected = YES;
        }
    }
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
        UIView *view = [self viewWithTag:i + kButtonTag];
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
            [button setTitle:button.titleLabel.text forState:UIControlStateSelected];
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
    [self resetState:sender.tag];
    if ([self.delegate respondsToSelector:@selector(filterView:disSelectedItem:selectedIndex:)]) {
        [self.delegate filterView:self disSelectedItem:_normalDatas[sender.tag - kButtonTag] selectedIndex:(sender.tag - kButtonTag)];
    }
}

- (void)resetState:(NSInteger)index {
    for (UIButton *button in self.subviews) {
        if ([button isKindOfClass:[UIButton class]]) {
            if (button.tag == index) {
                button.selected = YES;
            } else {
                button.selected = NO;
            }
        }
    }
}

- (void)clear {
    [self removeAllSubviews];
}

@end
