//
//  THButton.h
//  THYG
//
//  Created by C on 2019/7/10.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, THButtonType) {
    THButtonType_Text               = -1,//只有文字
    THButtonType_Image              = 0,//只有图
    THButtonType_imageLeft          = 1,//左图右文
    THButtonType_imageTop           = 2,//上图下文
    THButtonType_imageRight         = 3,//左文右图
    THButtonType_ImageBottom        = 4,//上文下图
    
};


@interface THButton : UIView

/**
 normal 文案
 */
@property (nonatomic, copy) NSString *title;

/**
 字体大小
 */
@property (nonatomic, strong) UIFont *font;

/**
 正常的图片
 */
@property (nonatomic, strong) UIImage *image;

/**
 正常的文案颜色
 */
@property (nonatomic, strong) UIColor *textColor;
//图片和文字间的间距（默认是3）
/**
 margen
 */
@property (nonatomic, assign) CGFloat margen;

/**
 是否选中
 */
@property (nonatomic, assign) BOOL selected;

/**
 选中图案
 */
@property (nonatomic, strong) UIImage *selectedImage;

/**
 选中文字
 */
@property (nonatomic, strong) NSString *selectedTitle;

/**
 选中文字颜色
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/**
 高亮
 */
@property (nonatomic, assign) BOOL highlighted;

/**
 高亮文字颜色
 */
@property (nonatomic, strong) UIColor *highlightTextColor;

/**
 高亮图片
 */
@property (nonatomic, strong) UIImage *highlightImage;

/**
 selecter
 */
@property (nonatomic, assign, readonly) SEL aSelecter;

/**
 target
 */
@property (nonatomic, weak, readonly) id target;

/**
 initView

 @param buttonType type
 @return object
 */
- (instancetype)initWithButtonType:(THButtonType)buttonType;

/**
 initView

 @param buttonType type
 @return object
 */
+ (instancetype)buttonWithType:(THButtonType)buttonType;

/**
 添加点击方法

 @param target target
 @param action action
 */
- (void)addTarget:(id)target action:(SEL)action;

@end

