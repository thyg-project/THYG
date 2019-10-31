//
//  THCardTableViewCell.h
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THCardTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^(changedBlock))(BOOL rel);

@property (nonatomic, copy) void (^(showProductDetail))(BOOL show);


@property (nonatomic, assign) BOOL productDidSeledted;

@end

NS_ASSUME_NONNULL_END
