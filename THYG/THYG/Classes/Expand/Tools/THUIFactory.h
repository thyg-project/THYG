//
//  THUIFactory.h
//  THYG
//
//  Created by C on 2019/6/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface THUIFactory : NSObject

+ (UILabel *)labelWithText:(NSString *)text fontSize:(CGFloat)fontSize tintColor:(UIColor *)color;

/**
 * 快速创建UIButton
 */
+ (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImg fontSize:(CGFloat)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor borderColor:(UIColor *)borderColor radius:(CGFloat)radius target:(id)target action:(SEL)action;

/**
 * 创建UIButton (文字，图片)
 */
+ (UIButton *)buttonWithTitle:(NSString *)title image:(NSString *)image fontSize:(CGFloat)size textColor:(UIColor *)textColor target:(id)target action:(SEL)action;

/**
 * 通过图片创建按钮
 */
+ (UIButton *)buttonWithImage:(NSString *)image selectedImage:(NSString *)selectedImg target:(id)target action:(SEL)action;

/**
 * 通过背景图片创建按钮
 */
+ (UIButton *)buttonWithBackgroundImage:(NSString *)image target:(id)target action:(SEL)action;

/**
 * 通过标题创建按钮
 */
+ (UIButton *)buttonWithTitle:(NSString *)title fontSize:(CGFloat)size textColor:(UIColor *)textColor bgColor:(UIColor *)bgColor radius:(CGFloat)radius target:(id)target action:(SEL)action;


@end

