//
//  THSelectedCategoryView.h
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THCategoryDelegate;
@interface THSelectedCategoryView : UIView

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, weak) id <THCategoryDelegate> delegate;


- (void)showInView:(UIView *)inView;

@end

@protocol THCategoryDelegate <NSObject>

- (void)dismiss:(THSelectedCategoryView *)view;;

- (void)catogoryView:(THSelectedCategoryView *)category didSelectedItem:(NSString *)item;

@end
