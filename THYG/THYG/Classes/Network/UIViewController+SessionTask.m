//
//  UIViewController+SessionTask.m
//  THYG
//
//  Created by C on 2019/7/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "UIViewController+SessionTask.h"
#import <objc/runtime.h>
#import "YGNetWorkTools.h"

@implementation UIViewController (SessionTask)


- (void)setTask:(NSURLSessionTask *)task {
    objc_setAssociatedObject(self, @selector(task), task, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSURLSessionTask *)task {
    return objc_getAssociatedObject(self, @selector(task));
}

- (void)setTasks:(NSMutableArray *)tasks {
    objc_setAssociatedObject(self, @selector(tasks), tasks, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableArray *)tasks {
    return objc_getAssociatedObject(self, @selector(tasks));
}

- (void)addTask:(NSURLSessionTask *)task {
    [self.tasks addObject:task];
}

- (void)cancelTask {
    if (self.task) {
        [YGNetWorkTools cancelTask:self.task];
        return;
    }
    if (YGInfo.validArray(self.tasks)) {
        [YGNetWorkTools  cancelTasks:self.tasks];
    }
}

@end
