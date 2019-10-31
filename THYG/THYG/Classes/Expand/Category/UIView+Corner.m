//
//  UIView+Corner.m
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "UIView+Corner.h"



@implementation UIView (Corner)

- (void)setCornerRadius:(CGFloat)radius inCorners:(UIRectCorner)corners {
    UIBezierPath *rounded = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                  byRoundingCorners:corners
                                                        cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *shape = [[CAShapeLayer alloc] init];
    [shape setPath:rounded.CGPath];
    self.layer.mask = shape;
}

@end
