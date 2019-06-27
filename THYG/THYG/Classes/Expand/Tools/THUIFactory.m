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
    label.textColor = color;
    return label;
}


@end
