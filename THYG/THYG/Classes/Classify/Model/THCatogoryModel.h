//
//  THCatogoryModel.h
//  THYG
//
//  Created by C on 2019/10/16.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THCatogoryModel : NSObject



/*
 id = 8;
 image = "http://th1818.d3d.cc/public/upload/category/2018/06-26/cdbb7d447a2b6117ba0cae52a8884cc8.png";
 "mobile_name" = "\U540d\U9152\U8317\U8336";
 "sort_order" = 8;
 */
@property (nonatomic, copy) NSString *image;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger sort_order;

@property (nonatomic, assign) NSInteger ca_id;

@end

NS_ASSUME_NONNULL_END
