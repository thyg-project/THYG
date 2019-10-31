//
//  THHomeMallActivityItemCell.h
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "THHomeActivityModel.h"

typedef NS_ENUM(NSUInteger, ActivityItemCellType) {
	ActivityItemCellTypeSpeedKill = 0,
	ActivityItemCellTypeNormal,
};


@interface THHomeMallActivityItemCell : UICollectionViewCell

@property (assign, nonatomic) ActivityItemCellType itemType;

@property (nonatomic, strong) THHomeActivityModel *activityModel;

@end
