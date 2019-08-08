//
//  THScreeningView.h
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THScreeningViewDelegate;
@interface THScreeningView : UIControl

@property (nonatomic, copy) NSArray <NSDictionary *>*dataArray;
@property (nonatomic, weak) id <THScreeningViewDelegate> delegate;

- (void)showInView:(UIView *)inView;

@end

@protocol THScreeningViewDelegate <NSObject>

- (void)screenResultContainer:(THScreeningView *)container catId:(NSString *)catId startProce:(NSString *)startPrice endPrice:(NSString *)endPrice;

@end

@interface THScreeningViewSectionHead : UICollectionReusableView

@property (nonatomic, strong) UILabel *titleLabel;

@end

