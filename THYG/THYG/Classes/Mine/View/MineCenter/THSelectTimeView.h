//
//  THSelectTimeView.h
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THSelectTimeViewDelegate <NSObject>

- (void)dismiss;

- (void)selectedItemWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

@interface THSelectTimeView : UIView

@property (nonatomic, weak) id <THSelectTimeViewDelegate> delegate;

- (void)showInView:(UIView *)inView;

@end
