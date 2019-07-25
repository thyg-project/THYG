//
//  THCardSettleView.h
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THCardSettleDelegate;

typedef NS_ENUM(NSInteger, THCardOperaType) {
    THCardOperaType_Settle              = 0,
    THCardOperaType_Editing             = 1,
};

@interface THCardSettleView : UIView

@property (nonatomic, weak) id <THCardSettleDelegate> delegate;

@property (nonatomic, assign) THCardOperaType operaType;

- (void)updateContentText:(NSString *)text;
@end


@protocol THCardSettleDelegate <NSObject>

- (void)selectedAll:(THCardSettleView *)settleView selected:(BOOL)selected;

- (void)deleteGoods:(THCardSettleView *)settleView;

- (void)move:(THCardSettleView *)settleView;

- (void)share:(THCardSettleView *)settleView;

- (void)settle:(THCardSettleView *)settleView;

@end

