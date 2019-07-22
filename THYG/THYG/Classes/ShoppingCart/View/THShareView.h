//
//  THShareView.h
//  THYG
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface THShareObject : NSObject

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) id thumbnail;

@property (nonatomic, strong) id shareImage;

@end

@interface THShareView : UIView

@property (nonatomic, strong) THShareObject *shareObject;

// 选择分享
@property (nonatomic, copy) void(^selectItemBlock)(NSInteger index);



/**
 *  初始化
 *
 *  @param titleArray 标题数组
 *  @param imageArray 图片数组(如果不需要的话传空数组(@[])进来)
 *
 *  @return ShareView
 */

- (instancetype)initShareViewWithTitle:(NSArray *)titleArray andImageArry:(NSArray *)imageArray;

@end
