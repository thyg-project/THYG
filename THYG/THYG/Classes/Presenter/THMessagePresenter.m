//
//  THMessagePresenter.m
//  THYG
//
//  Created by C on 2019/7/26.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THMessagePresenter.h"

@implementation THMessagePresenter


- (void)loadSystemMessage {
    [self performToSelector:@selector(loadMessageSuccess:) params:nil];
}


@end
