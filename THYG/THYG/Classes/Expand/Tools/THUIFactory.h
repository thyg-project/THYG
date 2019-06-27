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

@end

