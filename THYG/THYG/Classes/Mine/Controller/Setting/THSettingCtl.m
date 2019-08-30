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
        NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        [self cleanCaches:filePath];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [THHUDProgress showSuccess:@"清理缓存成功"];
        });
    }
}

#pragma mark - 清除缓存
- (void)cleanCaches:(NSString *)path {
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    [[YYImageCache sharedCache].diskCache removeAllObjects];
    
    // 清理wk缓存
    if (@available(iOS 9.0, *)) {
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] modifiedSince:[NSDate dateWithTimeIntervalSince1970:0] completionHandler:^{
            
        }];
    }
    // 清理url cache （get/webview）
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
