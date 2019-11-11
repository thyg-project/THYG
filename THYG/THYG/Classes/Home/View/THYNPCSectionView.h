//
//  THYNPCSectionView.h
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THYNPCSectionView : UIView

@property (nonatomic, copy) void (^(selectHandler))(NSInteger index);

@end

NS_ASSUME_NONNULL_END
