//
//  THTaskPresenter.m
//  THYG
//
//  Created by C on 2019/8/19.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTaskPresenter.h"

@implementation THTaskPresenter

- (void)getTaskListData {
   NSURLSessionTask *task = [YGNetworkCommon getTaskListSuccess:^(id responseObject) {
       [self performToSelector:@selector(getTaskListSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(getTaskListFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
