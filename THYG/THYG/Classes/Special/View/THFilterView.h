//
//  THFilterView.h
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THFilterViewDelegate;

@interface THFilterView : UIView


@property (nonatomic, strong) NSArray <NSString *> *normalTitles;

@property (nonatomic, strong) NSArray <NSString *> *selectedTitles;

@property (nonatomic, strong) UIFont *font;

@property (nonatomic, strong) UIColor *normalColor;

@property (nonatomic, strong) UIColor *selectedColor;

@property (nonatomic, weak) id <THFilterViewDelegate> delegate;

@property (nonatomic, assign) CGFloat imageMargenToText;

- (instancetype)initWithDatas:(NSArray <NSString *>*)datas;

- (void)setImage:(UIImage *)image selectedImage:(UIImage *)selectedImage index:(NSInteger)index;

@end

@protocol THFilterViewDelegate <NSObject>

- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index;

@end

