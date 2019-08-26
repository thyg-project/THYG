//
//  THUIFactory.m
//  THYG
//
//  Created by C on 2019/6/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THUIFactory.h"

@implementation THUIFactory

+ (UILabel *)labelWithText:(NSString *)text fontSize:(CGFloat)fontSize tintColor:(UIColor *)color {
    UILabel *label = [UILabel new];
    label.text = text;
    label.font = [UIFont systemFontOfSize:fontSize > 0 ? fontSize : 17];
    if (color) {
        label.textColor = color;
    }
    return label;
}

/**
 * 快速创建UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImg fontSize:(CGFloat)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor radius:(CGFloat)radius target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (YGInfo.validString(title)) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (YGInfo.validString(image)) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (YGInfo.validString(selectedImg)) {
        [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    }
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:size > 0 ? : 17];
    button.adjustsImageWhenHighlighted = NO;
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (borderColor) {
        button.layer.borderColor = borderColor.CGColor;
        button.layer.borderWidth = 1;
    }
    if (radius) {
        button.layer.cornerRadius = radius;
    }
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

/**
 * 创建UIButton (文字，图片)
 */
+ (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image fontSize:(CGFloat)size textColor:(UIColor *)textColor target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (YGInfo.validString(title)) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    if (YGInfo.validString(image)) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:size > 0 ? : 17];;
    button.adjustsImageWhenHighlighted = NO;
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}


/**
 * 通过图片创建按钮
 */
+ (UIButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImg target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (YGInfo.validString(image)) {
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    if (YGInfo.validString(selectedImg)) {
        [button setImage:[UIImage imageNamed:selectedImg] forState:UIControlStateSelected];
    }
    button.adjustsImageWhenHighlighted = NO;
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

/**
 * 通过背景图片创建按钮
 */
+ (UIButton *)buttonWithBackgroundImage:(NSString *)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (YGInfo.validString(image)) {
        [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    button.adjustsImageWhenHighlighted = NO;
    if (target) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}

/**
 * 通过标题创建按钮
 */
+ (UIButton *)buttonWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor radius:(CGFloat)radius target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if (YGInfo.validString(title)) {
        [button setTitle:title forState:UIControlStateNormal];
    }
    button.titleLabel.font = [UIFont systemFontOfSize:size > 0 ? : 17];
    if (textColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
    }
    if (bgColor) {
        [button setBackgroundColor:bgColor];
    }
    button.adjustsImageWhenHighlighted = NO;
    if (radius) {
        button.layer.cornerRadius = radius;
    }
    if (action) {
        [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return button;
}




@end
