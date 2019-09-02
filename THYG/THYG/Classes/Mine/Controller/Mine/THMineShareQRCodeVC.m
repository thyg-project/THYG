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

@property (nonatomic, strong) THShareView *shareView;

@end

@implementation THMineShareQRCodeVC

- (THShareView *)shareView {
    if (!_shareView) {
        _shareView = [THShareView new];
        [_shareView setSelectItemBlock:^(NSInteger index) {
            
        }];
        THShareObject *object = [THShareObject new];
        object.content = @"二维码";
        _shareView.shareObject = object;
    }
    return _shareView;
}

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
    [self.shareView showInView:UIApplication.sharedApplication.delegate.window];
}


@end
