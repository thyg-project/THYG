//
//  THMineNavigationView.h
//  THYG
//
//  Created by C on 2019/7/15.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
@class THButton;
@protocol THNaviagationViewDelegate;

@interface THNavigationView : UIView


/**
 标题
 */
@property (nonatomic, copy, nullable) NSString *content;

/**
 标题字体大小
 */
@property (nonatomic, copy, nullable) UIFont *contentSize;

/**
 标题颜色
 */
@property (nonatomic, strong, nullable) UIColor *textColor;

/**
 委托
 */
@property (nonatomic, weak, nullable) id <THNaviagationViewDelegate> delegate;

/**
 自定义导航栏右边图片按钮集合
 */
@property (nonatomic, strong, nullable) NSArray <UIImage *> *rightButtonsImages;

@property (nonatomic, strong, nullable) NSArray <UIImage *> *rightSelctedImages;

/**
 自定义导航栏右边文字按钮集合
 */
@property (nonatomic, strong, nullable) NSArray <NSString *> *rightButtonTitles;

/**
 自定义导航栏右边图片按钮
 */
@property (nonatomic, strong, nullable) UIImage *rightButtonImage;

/**
 选中图片
 */
@property (nonatomic, strong, nullable) UIImage *rightSelectedImage;

/**
 自定义导航栏右边文字按钮
 */
@property (nonatomic, copy, nullable) NSString *rightButtonTitle;

/**
 自定义导航栏左边图片按钮
 */
@property (nonatomic, strong, nullable) UIImage *leftButtonImage;

/**
 自定义导航栏左边文字按钮
 */
@property (nonatomic, copy, nullable) NSString *leftButtonTitle;

/**
 返回按钮文字颜色
 */
@property (nonatomic, strong, nullable) UIColor *backTextColor;

/**
 右边按钮文字颜色
 */
@property (nonatomic, strong, nullable) UIColor *rightTextColor;

/**
 返回按钮字体大小
 */
@property (nonatomic, strong, nullable) UIFont *backTextFont;

/**
 右边按钮字体大小
 */
@property (nonatomic, strong, nullable) UIFont *rightTextFont;

/**
 给标题设置富文本
 */
@property (nonatomic, strong, nullable) NSAttributedString *attributedContent;

/**
 右边按钮
 */
@property (nonatomic, strong, nullable, readonly) THButton *rightBarButton;

/**
 右边按钮集合
 */
@property (nonatomic, strong, nullable, readonly) NSArray <THButton *> *rightBarButtons;


@property (nonatomic, strong, nullable) UIView *customLeftView;

@property (nonatomic, strong, nullable) UIView *customRightView;

/**
 自定义view
 */
@property (nonatomic, strong, nullable) UIView *titleView;

@end

@protocol THNaviagationViewDelegate <NSObject>

@optional

- (void)back:(THNavigationView *_Nullable)navigationView;

- (void)rightAction:(NSInteger)index container:(THNavigationView *_Nullable)navigationView;

- (void)contentDidTouch:(nullable id)content container:(THNavigationView *_Nullable)navigation;





@end

