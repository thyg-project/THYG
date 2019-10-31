//
//  THCatogoryRightView.h
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THCategoryRightViewDelegate;

@interface THCatogoryRightView : UIView

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) NSArray *modes;

@property (nonatomic, weak) id <THCategoryRightViewDelegate>delegate;

@end


@protocol THCategoryRightViewDelegate <NSObject>

- (void)categoryView:(THCatogoryRightView *)categoryView searchContent:(NSString *)content;


- (void)categoryView:(THCatogoryRightView *)categoryView filterInfo:(NSDictionary *)info;


- (void)categoryView:(THCatogoryRightView *)categoryView itemDidSelctedIndexPath:(NSIndexPath *)indexPath;

@end

