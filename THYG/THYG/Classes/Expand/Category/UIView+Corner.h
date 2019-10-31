//
//  UIView+Corner.h
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Corner)

- (void)setCornerRadius:(CGFloat)radius inCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
