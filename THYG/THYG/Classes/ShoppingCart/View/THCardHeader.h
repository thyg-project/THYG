//
//  THCardHeader.h
//  THYG
//
//  Created by C on 2019/10/28.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface THCardHeader : UIView


@property (nonatomic, assign) BOOL empty;

- (void)setContent:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
