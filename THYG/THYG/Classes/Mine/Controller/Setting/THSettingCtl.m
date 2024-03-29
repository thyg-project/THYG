//
//  THSettingCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSettingCtl.h"
#import "THUserInfoEditCtl.h"
#import "THHelpCenterCtl.h"
#import "THAddressVC.h"
#import "THModifyPwdVC.h"
#import "THAboutTHCtl.h"
#import "THSettingPresenter.h"
#import <WebKit/WebKit.h>

@interface THSettingCtl () <THSettingProtocol> {
    NSArray *_classList;
}

@property (nonatomic,strong) UIView *footer;

@property (nonatomic, strong) THSettingPresenter *presenter;

@end

@implementation THSettingCtl

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self = [[UIStoryboard storyboardWithName:@"THSettingCtl" bundle:nil] instantiateInitialViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号设置";
    _presenter = [[THSettingPresenter alloc] initPresenterWithProtocol:self];
    [self addBackBarItem];
    self.tableView.tableFooterView = [UIView new];
    _classList = @[@"THUserInfoEditCtl",@"THModifyPwdVC",@"THAddressVC",@"THAboutTHCtl",@"",@"THHelpCenterCtl"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < 2 && YGInfo.validString(THUserManager.sharedInstance.userInfo.district) == NO) {
        return 0;
    }
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return self.footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (YGInfo.validString(THUserManager.sharedInstance.userInfo.district) == NO) {
        return 0;
    }
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class class = NSClassFromString(_classList[indexPath.row]);
    if (class) {
        UIViewController *controller = [[class alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [THHUDProgress show:@"清理缓存中..."];
        [self.presenter clearCache];
    }
}

#pragma mark -- 退出账户
- (void)loginOutBtn {
    [self.presenter logout];
}

- (UIView *)footer {
    if (!_footer) {
        _footer = [[UIView alloc] init];
        UIButton *loginOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        loginOutBtn.frame = CGRectMake(20, 20, kScreenWidth - 40, 40);
        loginOutBtn.backgroundColor = RGB(213, 0, 27);
        loginOutBtn.titleLabel.font = Font(15);
        loginOutBtn.layer.masksToBounds = YES;
        loginOutBtn.layer.cornerRadius = 5;
        [loginOutBtn setTitle:@"退出账户" forState:UIControlStateNormal];
        [loginOutBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [loginOutBtn addTarget:self action:@selector(loginOutBtn) forControlEvents:UIControlEventTouchUpInside];
        [_footer addSubview:loginOutBtn];
    }
    return _footer;
}

- (void)logoutSuccess {
    [THHUDProgress showMessage:@"退出成功"];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)clearCacheSuccess {
    [THHUDProgress showSuccess:@"清理缓存成功"];
}

@end
