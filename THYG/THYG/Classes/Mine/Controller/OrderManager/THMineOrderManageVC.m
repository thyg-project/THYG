//
//  THMineOrderManageVC.m
//  THYG
//
//  Created by Mac on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderManageVC.h"
#import "THMineOrderListPageVC.h"

@interface THMineOrderManageVC () <WMPageControllerDelegate, WMPageControllerDataSource> {
    NSArray *_stateList;
}

@property (nonatomic, strong) NSArray *localizedTitles;


@end

@implementation THMineOrderManageVC

- (NSArray *)localizedTitles {
    if (!_localizedTitles) {
        _localizedTitles = self.type ? @[@"全部",@"待确认",@"待退回",@"已完成"] : @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
        _stateList = self.type ? @[@"", @"0", @"1", @"3"] : @[@"", @"WAITPAY", @"WAITSEND",@"WAITRECEIVE",@"WAITCCOMMENT"];
    }
    return _localizedTitles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackBarItem];
    [self setupUI];
}

- (void)setupUI {
    self.navigationItem.title = self.type ? @"退/换货订单" : @"我的订单";
    self.titleColorNormal = RGB(102, 102, 102);
    self.titleColorSelected = RGB(213, 0, 27);
    self.titleSizeNormal = 14;
    self.titleSizeSelected = 16;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.localizedTitles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.localizedTitles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    THMineOrderListPageVC *vc = [[THMineOrderListPageVC alloc] init];
    vc.title = self.localizedTitles[index];
    vc.status = _stateList[index++];
    vc.type = self.type;
    return vc;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, kScreenWidth, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat y = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, y, kScreenWidth, kScreenHeight - y);
}

@end
