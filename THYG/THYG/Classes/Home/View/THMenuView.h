//
//  THHomeShowMenuView.h
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THMemuViewDelegate;

@interface THMenuView : UIControl

/** 数据源 */
@property (nonatomic,strong) NSArray *data;
/** 选择事件*/
@property (nonatomic, weak) id <THMemuViewDelegate> delegate;


@property (nonatomic, assign, readonly) CGRect visibleRect;

- (void)show;

- (void)showRect:(CGRect)rect;

- (void)dismiss;

@end

@protocol THMemuViewDelegate <NSObject>

- (void)menuView:(THMenuView *)menuView didSelectedIndex:(NSInteger)index;

- (void)menuViewDismiss:(THMenuView *)menuView;

@end
