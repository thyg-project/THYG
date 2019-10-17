//
//  THHomeHeaderItemCell.h
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THCatogoryModel.h"
@class THHomeHeaderItemModel;
@interface THHomeHeaderItemCell : UICollectionViewCell
@property (nonatomic, strong) THHomeHeaderItemModel * itemModel;
@property (assign, nonatomic) BOOL isClassifyItem;
@property (nonatomic, strong) THCatogoryModel * item;
@end
