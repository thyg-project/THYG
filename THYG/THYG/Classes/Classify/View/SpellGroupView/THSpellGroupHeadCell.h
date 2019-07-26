//
//  THSpellGroupHeadCell.h
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THSpellModel : NSObject

- (instancetype)initWithTime:(NSString *)time state:(NSString *)state validate:(BOOL)validate;

@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, assign) BOOL validate;

@end

@interface THSpellGroupHeadCell : UICollectionViewCell

- (void)refreshWithModel:(THSpellModel*)model;

@end
