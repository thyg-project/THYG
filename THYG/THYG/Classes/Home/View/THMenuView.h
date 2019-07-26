//
//  THHomeShowMenuView.h
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THMemuViewDelegate;

typedef NS_ENUM(NSInteger, THMenuViewItemTextAlignment) {
    THMenuViewItemTextAlignment_Left                = 0,
    THMenuViewItemTextAlignment_Center              = 1,
    THMenuViewItemTextAlignment_Right               = 2
};
@interface THMenuView : UIControl

/** 数据源 */
@property (nonatomic,strong) NSArray *data;
/** 选择事件*/
@property (nonatomic, weak) id <THMemuViewDelegate> delegate;
//default center
@property (nonatomic, assign) THMenuViewItemTextAlignment itemAlignment;

@property (nonatomic, assign, readonly) CGRect visibleRect;

- (void)show;

- (void)showRect:(CGRect)rect;

- (void)dismiss;

@end

@protocol THMemuViewDelegate <NSObject>

@optional

- (void)menuView:(THMenuView *)menuView didSelectedIndex:(NSInteger)index;

- (void)menuViewDismiss:(THMenuView *)menuView;

- (void)menuView:(THMenuView *)menuView didSelectedItem:(NSString *)item index:(NSInteger)index;

@end
