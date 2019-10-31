//
//  THMineVC.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineVC.h"
#import "THMineSectionCell.h"
#import "THMineAdCell.h"
#import "THMineOrderHeaderCell.h"
#import "THMineHeaderView.h"
#import "THLoginVC.h"
#import "THMineShareQRCodeVC.h"
#import "THMyCollectCtl.h"
#import "THMineOrderManageVC.h"
#import "THUserInfoEditCtl.h"
#import "THFavouriteGoodsModel.h"
#import "THGoodsListOfCollectionLayoutCell.h"
#import "THMinePresenter.h"
#import "THNavigationView.h"
#import "THMenuView.h"
#import "THMyMessageCtl.h"
#import "THButton.h"
#import "THMyOrderView.h"
#import "THMyToolsPage.h"
#import "THEverydayGoodsView.h"


@interface THMineVC () <UIScrollViewDelegate,THMineProtocol, THMemuViewDelegate, THMineHeaderDelegate, THMyOrderViewDelegate, THEvertGoodsDelegate, THToolsPageDelegate> {
	NSArray *_dataArray;
    CGFloat _lastOffsetY;
    THNavigationView *_customNav;
    THMenuView *_munuView;
    NSArray *_tableViewClass;
    THMyOrderView *_orderView;
    THMyToolsPage *_toolsView;
    THEverydayGoodsView *_everydayView;
    UIView *_containerView;
}
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) THMineHeaderView *headView;
@property (nonatomic, strong) THMinePresenter *presenter;
@end

@implementation THMineVC

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

#pragma mark - 更新用户信息
- (void)updateUserInfo {
    [self.headView refreshUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THMinePresenter alloc] initPresenterWithProtocol:self];

    _tableViewClass = @[@"",@"THMineShareQRCodeVC",@"THMineSubmitApplicationVC",@"THMineApplymentVC",@"THInvitationManageCtl",@"THMyCollectCtl",@"THTeCtl",@"THMyCollectCtl",@"THMineWalletVC",@"THSettingCtl"];
    [self.presenter getLocailData];
    [self addNav];
    [self addMainView];
    [self.view bringSubviewToFront:_customNav];
    [self addOrderView];
    [self addToolsView];
    [self addEverydayGoodsView];
    [self autoLayoutSizeContentView:self.mainScrollView];
    [self addMenuView];
    [self.presenter goodsFavourite];
}

- (void)addToolsView {
    _toolsView = [[THMyToolsPage alloc] init];
    _toolsView.delegate = self;
    [_containerView addSubview:_toolsView];
    [_toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_orderView.mas_bottom).offset(16);
        make.left.right.equalTo(_orderView);
        make.height.mas_equalTo(212);
    }];
}

- (void)addEverydayGoodsView {
    _everydayView = [[THEverydayGoodsView alloc] init];
    _everydayView.delegate = self;
    [_containerView addSubview:_everydayView];
    [_everydayView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.right.equalTo(_orderView);
        make.top.equalTo(_toolsView.mas_bottom).offset(16);
        make.height.bottom.equalTo(@(-8));
        make.height.mas_equalTo(504);
    }];
}

- (void)addOrderView {
    _orderView = [[THMyOrderView alloc] init];
    _orderView.delegate = self;
    [_containerView addSubview:_orderView];
    [_orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@-16);
        make.top.equalTo(@(126 + kStatesBarHeight));
        make.height.mas_equalTo(131);
    }];
}

- (void)addMainView {
    _mainScrollView = [[UIScrollView alloc] init];
    _mainScrollView.delegate = self;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_mainScrollView];
    _mainScrollView.backgroundColor = UIColorHex(0xF7F8F9);
    [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _containerView = [UIView new];
    _containerView.backgroundColor = [UIColor clearColor];
    [_mainScrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainScrollView);
        make.width.mas_equalTo(kScreenWidth);
    }];
    [_containerView addSubview:self.headView];
}

- (void)addNav {
    _customNav = [[THNavigationView alloc] init];
    _customNav.backgroundColor = RGB(213, 0, 27);
    _customNav.content = @"个人中心";
    _customNav.alpha = 0;
    _customNav.textColor = [UIColor whiteColor];
    THButton *left = [THButton buttonWithType:THButtonType_imageTop];
    left.title = @"扫一扫";
    left.frame = CGRectMake(0, 0, 40, 40);
    left.font = [UIFont systemFontOfSize:9];
    left.textColor = [UIColor whiteColor];
    left.image = [UIImage imageNamed:@"扫一扫.png"];
    [left addTarget:self action:@selector(scan)];
    _customNav.customLeftView = left;
    _customNav.leftButtonImage = nil;
    THButton *right = [THButton buttonWithType:THButtonType_imageTop];
    right.frame = CGRectMake(0, 0, 40, 40);
    right.title = @"更多";
    right.textColor = [UIColor whiteColor];
    right.font = [UIFont systemFontOfSize:9];
    right.image = [UIImage imageNamed:@"更多.png"];
    [right addTarget:self action:@selector(more)];
    _customNav.customRightView = right;
    [self.view addSubview:_customNav];
    [_customNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNaviHeight);
    }];
}

- (void)addMenuView {
    _munuView = [THMenuView new];
    _munuView.data = @[@"推广二维码",@"我的消息",@"关注"];
    _munuView.delegate = self;
    [self.view addSubview:_munuView];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView != self.mainScrollView) {
        return;
    }
    CGPoint offset = scrollView.contentOffset;
    if (offset.y < 0) {
        CGRect rect = self.headView.frame;
        rect.origin.y = offset.y;
        rect.size.height = CGRectGetHeight(rect)-offset.y;
        self.headView.headImgView.frame = rect;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    _lastOffsetY = offsetY;
    CGFloat alpha = 0;
    if (offsetY > 10) {
        alpha = MIN(1, 1 - ((10 + kNaviHeight - offsetY) / kNaviHeight));
    }
     _customNav.alpha = alpha;
}

- (void)pushWithIndexPath:(NSIndexPath *)indexPath {
    Class class = NSClassFromString(_tableViewClass[indexPath.row]);
    if (class) {
        UIViewController *controller = [[class alloc] init];
        if (indexPath.row == 1) {
            [controller setValue:@(indexPath.row == 2 ? MineGoodsTypeScanHistory : MineGoodsTypeMyAttention) forKey:@"type"];
        }
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (THMineHeaderView *)headView {
	if (_headView == nil) {
		_headView = [[THMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  140 + kStatesBarHeight)];
        _headView.delegate = self;
	}
	return _headView;
}


#pragma mark --THPresenterProtocol
- (void)getLocalDataSuccess:(NSArray<NSArray<NSString *> *> *)datas {
    _dataArray = datas;
}

- (void)signSuccess:(NSDictionary *)response {
    [self.headView udpateSignState];
}

- (void)signFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)autoLogout {
    [self updateUserInfo];
}

- (void)scan {
    
}

- (void)more {
    if (CGRectGetHeight(_munuView.visibleRect) > 0) {
        [_munuView dismiss];
    } else {
        //菜单
        [_munuView showRect:CGRectMake(0, kNaviHeight, kScreenWidth, kScreenHeight - kNaviHeight - kTabBarHeight)];
    }
}

#pragma mark --THMenuViewDelegate
- (void)menuViewDismiss:(THMenuView *)menuView {
    [menuView dismiss];
}

- (void)menuView:(THMenuView *)menuView didSelectedIndex:(NSInteger)index {
    [menuView dismiss];
    if (THUserManager.hasLogin == NO) {
        THLoginVC *loginVc = [[THLoginVC alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
        return;
    }
    UIViewController *controller = nil;
    if (index == 0) {//我的二维码
        controller = [[THMineShareQRCodeVC alloc] init];
    } else if (index == 1) {//我的消息
        controller = [[THMyMessageCtl alloc] init];
    } else {//我的关注
        controller = [[THMyCollectCtl alloc] init];
    }
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -THHeaderViewDelegate
- (void)sign:(THMineHeaderView *)sender {
    if (THUserManager.hasLogin) {
        [self.presenter sign];
    } else {
        THLoginVC *loginVc = [[THLoginVC alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

- (void)toUserInfo:(THMineHeaderView *)sender {
    if (THUserManager.hasLogin) {
        THUserInfoEditCtl *edit = [[THUserInfoEditCtl alloc] init];
        edit.title = @"个人资料编辑";
        [self.navigationController pushViewController:edit animated:YES];
    } else {
        THLoginVC *loginVc = [[THLoginVC alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }
}

- (void)orderView:(THMyOrderView *)orderView didClickState:(THOrderState)state {
    THMineOrderManageVC *manageVc = [[THMineOrderManageVC alloc] init];
    manageVc.menuViewStyle = WMMenuViewStyleLine;
    manageVc.automaticallyCalculatesItemWidths = YES;
    if (state != 3) {
        manageVc.selectIndex = (state==0) ? 1 : (state == 1) ? 3 : (state == 2) ? 4 : 0;
    } else {
        manageVc.type = 1;
        manageVc.selectIndex = 0;
    }
    [self.navigationController pushViewController:manageVc animated:YES];

}

- (void)toolPage:(THMyToolsPage *)page didSelectedIndexPath:(NSIndexPath *)indexPath content:(NSString *)content {
    [self pushWithIndexPath:indexPath];
}

- (void)moreGoods {
    
}

- (void)goodsView:(THEverydayGoodsView *)view didSelctedItem:(THFavouriteGoodsModel *)item {
    
}

- (void)loadFavouriteGoodsFailed:(NSDictionary *)errorInfo {
    
}

- (void)loadFavouriteGoodsSuccess:(NSArray<THFavouriteGoodsModel *> *)list {
    _everydayView.models = list.copy;
}

@end
