//
//  THMineHeaderView.h
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THMineHeaderDelegate;

@interface THMineHeaderView : UIView

@property (nonatomic,strong) UIImageView *headImgView;

@property (nonatomic, weak) id <THMineHeaderDelegate> delegate;

- (void)udpateSignState;

- (void)refreshUI;

@end

@protocol THMineHeaderDelegate <NSObject>

- (void)sign:(THMineHeaderView *)sender;

- (void)toUserInfo:(THMineHeaderView *)sender;

@end
