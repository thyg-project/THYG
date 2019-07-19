//
//  THBaseVC.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"
#import "THBaseProtocol.h"

@interface THBaseVC () <THBaseProtocol>

@end

@implementation THBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.view.backgroundColor = BGColor;
    
}

- (BOOL)fd_interactivePopDisabled {
    return NO;
}

- (BOOL)fd_prefersNavigationBarHidden {
    return NO;
}

- (void)getTask:(NSURLSessionTask *)task {
    [self addTask:task];
}

- (void)dealloc {
    [self cancelTask];
}

@end
