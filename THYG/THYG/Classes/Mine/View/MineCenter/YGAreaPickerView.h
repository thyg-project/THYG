//
//  YGAreaPickerView.h
//  test
//
//  Created by C on 2018/12/10.
//  Copyright © 2018 C. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGProvince.h"

NS_ASSUME_NONNULL_BEGIN

@protocol YGAreaPickerViewDelegate <NSObject>

- (void)didSelectedPro:(YGProvince *)pro city:(YGCity *)city area:(YGDistrict *)area;

@end

@interface YGAreaPickerView : UIView

@property (nonatomic, weak) id <YGAreaPickerViewDelegate> delegate;

@property (nonatomic, strong, readonly) UIView *container;

- (void)showInView:(UIView *)inView;


@end

NS_ASSUME_NONNULL_END
