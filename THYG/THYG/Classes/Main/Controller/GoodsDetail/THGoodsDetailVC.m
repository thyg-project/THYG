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
#import "THShareView.h"
#import "THGoodsInfoPresenter.h"

@interface THGoodsDetailVC () <WMMenuItemDelegate,WMMenuViewDelegate,WMMenuViewDataSource,WMPageControllerDelegate,WMPageControllerDataSource, THGoodsDetailDelegate, THGoodDetailBottomViewDelegate, THGoodsInfoProtocol> {
    NSString *_loadContent;
    YGWebViewController *_webContainer;
}
@property (nonatomic, strong) THGoodsDetailBottomView *bottomView;
@property (nonatomic, strong) NSArray <NSString *> *localizedTitles;
/** 商品详情数组*/
@property (nonatomic, strong) THGoosDetailModel *detailModel;

@property (nonatomic, strong) THGoodsInfoPresenter *presenter;

// 所选规格id和商品数量
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *count;

@end

@implementation THGoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addBackBarItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} forState:UIControlStateSelected];
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.preloadPolicy = WMPageControllerPreloadPolicyNeighbour;
    self.showOnNavigationBar = YES;
    self.selectIndex = 0;
    self.titleColorSelected = [UIColor whiteColor];
    _presenter = [[THGoodsInfoPresenter alloc] initPresenterWithProtocol:self];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    self.itemId = @"0";
    self.count = @"1";
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
        [(THGoodsVC *)controller setDelegate:self];
        [controller setValue:self.goodsId forKey:@"goods_id"];
    } else if (index == 1) {
        controller = [YGWebViewController new];
        _webContainer = (YGWebViewController *)controller;
        if (_loadContent) {
            _webContainer.loadContent = _loadContent;
        }
       
    } else {
        controller = [THCommentVC new];
        [controller setValue:self.goodsId forKey:@"goods_id"];
    }
    return controller;
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    return [super menuView:menu widthForItemAtIndex:index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, kScreenWidth, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 0, kScreenWidth, kScreenHeight - 50);
}

- (void)getWebContentSuccess:(NSString *)content {
    _loadContent = content;
    if (_webContainer) {
        _webContainer.loadContent = content;
    }
}

- (void)goodsGuiGeComplete:(NSString *)itemId count:(NSString *)count {
    self.itemId = itemId;
    self.count = count;
}

#pragma mark - LazyLoad
- (THGoodsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[THGoodsDetailBottomView alloc] init];
        _bottomView.delegate = self;
    }
    return _bottomView;
}
///@"客服"/*,@"关注"*/,@"购物车",@"加入购物车"/*,@"立即购买"*/
- (void)bottomViewDidSelectedIndex:(NSInteger)index {
    if (index == 0) {
        
    } else if (index == 1) {
        
    } else if (index == 2) {
        [self.presenter addCard:self.goodsId goodsNum:self.count itemId:self.itemId];
    }
}

- (void)addCardFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)addCardSuccess:(NSDictionary *)response {
    [THHUDProgress dismiss];
    [THHUDProgress showMessage:@""];
}



@end
