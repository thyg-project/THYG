//
//  THHomeHeaderView.h
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THHomeHeaderView : UICollectionReusableView

@property (nonatomic, strong) NSArray * imageUrls;
@property (nonatomic, copy) void(^clickMenuItem)(NSInteger itemIndex, NSString *itemName);

@end
