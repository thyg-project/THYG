//
//  THGoodsDetailVC.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsDetailVC.h"
#import "THGoodsVC.h"
#import "THCommentVC.h"
#import "YGWebViewController.h"
#import "THShoppingCartCtl.h"
#import "THGoodsDetailBottomView.h"
#import "THGoosDetailModel.h"
#import "THGoodsCommentModel.h"
#import "THGoodsSpecModel.h"

@interface THGoodsDetailVC () <WMMenuItemDelegate,WMMenuViewDelegate,WMMenuViewDataSource,WMPageControllerDelegate,WMPageControllerDataSource> {
    
}
@property (nonatomic, strong) THGoodsDetailBottomView *bottomView;
@property (nonatomic, strong) NSArray <NSString *> *localizedTitles;
/** 商品详情数组*/
@property (nonatomic, strong) THGoosDetailModel *detailModel;

// 所选规格id和商品数量
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *count;

@end

@implementation THGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    self.showOnNavigationBar = YES;
    self.selectIndex = 0;
    self.titleColorSelected = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}

- (void)shareAction {
    
}

- (NSArray<NSString *> *)localizedTitles {
    if (!_localizedTitles) {
        _localizedTitles = @[@"商品",@"详情",@"评价"];
    }
    return _localizedTitles;
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.localizedTitles.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.localizedTitles[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *controller = nil;
    if (index == 0) {
        controller = [THGoodsVC new];
    } else if (index == 1) {
        controller = [YGWebViewController new];
        [controller setValue:@"https://www.baidu.com" forKey:@"loadUrl"];
    } else {
        controller = [THCommentVC new];
        [controller setValue:self.goodsId forKey:@"goods_id"];
    }
    return controller;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, kScreenWidth, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50);
}

#pragma mark - LazyLoad
- (THGoodsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[THGoodsDetailBottomView alloc] initWithFrame:CGRectZero];
        _bottomView.backgroundColor = [UIColor redColor];
    }
    return _bottomView;
}


@end
