//
//  THMineNavigationView.h
//  THYG
//
//  Created by C on 2019/7/15.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol THNaviagationViewDelegate;

@interface THNavigationView : UIView


/**
 标题
 */
@property (nonatomic, copy) NSString *content;

/**
 标题字体大小
 */
@property (nonatomic, copy) UIFont *contentSize;

/**
 标题颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 委托
 */
@property (nonatomic, weak) id <THNaviagationViewDelegate> delegate;

/**
 自定义导航栏右边图片按钮集合
 */
@property (nonatomic, strong) NSArray <UIImage *> *rightButtonsImages;

/**
 自定义导航栏右边文字按钮集合
 */
@property (nonatomic, strong) NSArray <NSString *> *rightButtonTitles;

/**
 自定义导航栏右边图片按钮
 */
@property (nonatomic, strong) UIImage *rightButtonImage;

/**
 自定义导航栏右边文字按钮
 */
@property (nonatomic, copy) NSString *rightButtonTitle;

/**
 自定义导航栏左边图片按钮
 */
@property (nonatomic, strong) UIImage *leftButtonImage;

/**
 自定义导航栏左边文字按钮
 */
@property (nonatomic, copy) NSString *leftButtonTitle;

/**
 返回按钮文字颜色
 */
@property (nonatomic, strong) UIColor *backTextColor;

/**
 右边按钮文字颜色
 */
@property (nonatomic, strong) UIColor *rightTextColor;

/**
 返回按钮字体大小
 */
@property (nonatomic, strong) UIFont *backTextFont;

/**
 右边按钮字体大小
 */
@property (nonatomic, strong) UIFont *rightTextFont;

/**
 给标题设置富文本
 */
@property (nonatomic, strong) NSAttributedString *attributedContent;

/**
 自定义view
 */
@property (nonatomic, strong) UIView *titleView;

@end

@protocol THNaviagationViewDelegate <NSObject>

@optional

- (void)back;

- (void)rightAction:(NSInteger)index;

- (void)contentDidTouch:(id)content;



@end

