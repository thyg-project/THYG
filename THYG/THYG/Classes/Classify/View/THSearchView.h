//
//  THSearchView.h
//  THYG
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THSearchResultDelegate;

@interface THSearchView : UIView

@property (nonatomic, strong) UIViewController *container;

@property (nonatomic, weak) id <THSearchResultDelegate> delegate;

@property (nonatomic, strong) NSArray *searchResult;

@end


@protocol THSearchResultDelegate <NSObject>

- (void)beginSearch:(NSString *)content;

- (void)pushNext:(id)model;

@end
