//
//  UIViewController+SessionTask.h
//  THYG
//
//  Created by C on 2019/7/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (SessionTask)
//单个网络请求任务
@property (nonatomic, strong) NSURLSessionTask *task;
//多个网络请求
@property (nonatomic, strong) NSMutableArray *tasks;

- (void)cancelTask;

- (void)addTask:(NSURLSessionTask *)task;

@end

NS_ASSUME_NONNULL_END
