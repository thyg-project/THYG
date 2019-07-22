//
//  THMineShareQRCodeVC.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineShareQRCodeVC.h"
#import "THShareView.h"

@interface THMineShareQRCodeVC ()
@property (weak, nonatomic) IBOutlet UIButton *shareButton;

@end

@implementation THMineShareQRCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置UI
- (void)setupUI {
    self.navigationItem.title = @"推广二维码";
    self.shareButton.layer.borderColor = RGB(213, 0, 27).CGColor;
    self.shareButton.layer.borderWidth = 1;
}

#pragma mark - share
- (IBAction)shareClick {
    THShareView *shareView = [[THShareView alloc] initShareViewWithTitle:@[@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"微博",@"复制链接"] andImageArry:@[@"weixin",@"pengyouquan",@"QQ",@"QQkongjian",@"xinlangweibo",@"fuzhilianjie"]];
    shareView.shareObject = [THShareObject new];
    shareView.shareObject.content = @"ahahhahaha";
    [self.navigationController.view addSubview:shareView];
    
    shareView.selectItemBlock = ^(NSInteger index) {
        NSLog(@"fenxiang %ld", index);
    };
}


@end
