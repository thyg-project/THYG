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

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) UIColor *textColor;

@property (nonatomic, weak) id <THNaviagationViewDelegate> delegate;

@property (nonatomic, strong) NSArray <UIImage *> *rightButtonsImages;

@property (nonatomic, strong) NSArray <NSString *> *rightButtonTitles;

@property (nonatomic, strong) UIImage *rightButtonImage;

@property (nonatomic, copy) NSString *rightButtonTitle;

@property (nonatomic, strong) UIImage *leftButtonImage;

@property (nonatomic, copy) NSString *leftButtonTitle;

@end

@protocol THNaviagationViewDelegate <NSObject>

@optional

- (void)back;

- (void)rightAction:(NSInteger)index;



@end

