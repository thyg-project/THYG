//
//  THCardSectionHeader.h
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THCardSectionHeader : UIView

@property (nonatomic, copy) void (^(SelectedBlock))(BOOL selected);

@end

NS_ASSUME_NONNULL_END
