//
//  THChangeCountView.h
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THChangeCountView : UIView


@property (nonatomic, copy) NSString *content;


@property (nonatomic, copy) void (^(ChangedBlock))(BOOL rel);


@end
