//
//  THTeCenterPresenter.m
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTeCenterPresenter.h"

@implementation THTeCenterPresenter

- (void)getTeData {
    NSMutableArray *array = [NSMutableArray new];
    for (int i = 0; i < 30; i ++) {
        THTeHuiModel *model = [THTeHuiModel new];
        [array addObject:model];
    }
    [self performToSelector:@selector(loadTeSuccess:) params:array];
}

@end
