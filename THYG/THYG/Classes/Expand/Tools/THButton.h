//
//  THButton.h
//  THYG
//
//  Created by C on 2019/7/10.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, THButtonType) {
    THButtonType_None               = -1,
    THButtonType_imageLeft          = 0,
    THButtonType_imageTop           = 1,
    THButtonType_imageRight         = 2,
    THButtonType_ImageBottom        = 3
};


@interface THButton : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) UIColor *textColor;
//图片和文字间的间距（默认是3）
@property (nonatomic, assign) CGFloat margen;

- (instancetype)initWithButtonType:(THButtonType)buttonType;

- (void)addTarget:(id)target action:(SEL)action;

@end

