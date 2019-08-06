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
	self.view.backgroundColor = kBackgroundColor;
    [self addBack];
}

- (void)addBack {
    if (self.fd_prefersNavigationBarHidden || self.navigationController.viewControllers.count <= 1) {
        return;
    }
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"back_white"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    backButton.imageInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.navigationItem.leftBarButtonItem = backButton;
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

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
