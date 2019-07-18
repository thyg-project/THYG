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
#import "THMineSubmitApplicationVC.h"
#import "THMyCollectCtl.h"
#import "THMyFootprintCtl.h"
#import "THCouponsCtl.h"
#import "THInvitationManageCtl.h"
#import "THMyTaskCtl.h"
#import "THMineOrderManageVC.h"
#import "THMineWalletVC.h"
#import "THUserInfoEditCtl.h"
#import "THSettingCtl.h"
#import "THMineApplymentVC.h"
#import "THFavouriteGoodsModel.h"
#import "THTeCtl.h"
#import "THGoodsListOfCollectionLayoutCell.h"
#import "THMinePresenter.h"
#import "THNavigationView.h"
#import "THMenuView.h"


@interface THMineVC () <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, THMineProtocol, THNaviagationViewDelegate> {
	NSArray *_dataArray;
    CGFloat _lastOffsetY;
    THNavigationView *_customNav;
    THMenuView *_munuView;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) THMineHeaderView *headView;
@property (nonatomic, strong) NSMutableArray *dataSource;
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

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUserInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THMinePresenter alloc] initPresenterWithProtocol:self];
    [self.presenter getLocailData];
    _customNav = [[THNavigationView alloc] init];
    _customNav.backgroundColor = GLOBAL_RED_COLOR;
    _customNav.content = @"个人中心";
    _customNav.alpha = 0;
    _customNav.textColor = [UIColor whiteColor];
    _customNav.leftButtonImage = nil;
    _customNav.delegate = self;
    _customNav.rightButtonsImages = @[[UIImage imageNamed:@"dingbugengduo"],[UIImage imageNamed:@"shezhi"]];
    [self.view addSubview:_customNav];
    [_customNav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(kNaviHeight);
    }];
	[self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:_customNav];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self autoLayoutSizeContentView:self.tableView];
	
	self.headView.checkOnBlock = ^{
        
		
	};
    [self addMenuView];
    [self.collectionView addRefreshHeaderAutoRefresh:YES animation:YES refreshBlock:^{
        
    }];
    [self.collectionView addRefreshFooterAutomaticallyRefresh:NO refreshComplate:^{
        
    }];
}

- (void)addMenuView {
    _munuView = [THMenuView new];
    _munuView.data = @[@"推广二维码",@"我的消息",@"关注"];
    [self.view addSubview:_munuView];
    [_munuView setSelectedAction:^(NSInteger index) {
        
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
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

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    } else if (section == 3) {
        return 5;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = nil;
	
	if (indexPath.section == 0) {
		THMineOrderHeaderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineOrderHeaderCell.class)];
        
        orderCell.orderAction = ^(NSInteger index) {
            THMineOrderManageVC *manageVc = [[THMineOrderManageVC alloc] init];
            manageVc.menuViewStyle = WMMenuViewStyleLine;
            manageVc.automaticallyCalculatesItemWidths = YES;
            manageVc.title = @"测试";
            if (index != 3) {
                manageVc.selectIndex = (index==0) ? 1 : (index == 1) ? 3 : (index == 2) ? 4 : 0;
            } else {
                manageVc.type = 1;
                manageVc.selectIndex = 0;
            }
            [self.navigationController pushViewController:manageVc animated:YES];
        };
        
		cell = orderCell;
        
        
	} else if ((indexPath.section > 0 && indexPath.section < 4) || indexPath.section == 5) {
		THMineSectionCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineSectionCell.class)];
		sectionCell.dataDict = _dataArray[indexPath.section][indexPath.row];
		sectionCell.accessoryType = indexPath.section == 5 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
		cell = sectionCell;
	} else {
		THMineAdCell *adCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineAdCell.class)];
		cell = adCell;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self pushWithIndexPath:indexPath];
}

- (void)pushWithIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            THMineShareQRCodeVC *shareVc = [[THMineShareQRCodeVC alloc] init];
            [self.navigationController pushViewController:shareVc animated:YES];
        } else if (indexPath.row == 1) {
            THMineSubmitApplicationVC *submitVc = [[THMineSubmitApplicationVC alloc] init];
             [self.navigationController pushViewController:submitVc animated:YES];
        } else {
            THMineApplymentVC *applyVc = [[THMineApplymentVC alloc] init];
             [self.navigationController pushViewController:applyVc animated:YES];
        }
        
    } else if (indexPath.section == 2){
        
        if (indexPath.row==0) {
            
            THCouponsCtl *coupons = [[THCouponsCtl alloc] init];
            coupons.title = _dataArray[indexPath.section][indexPath.row][@"title"];
             [self.navigationController pushViewController:coupons animated:YES];
            
        }else if (indexPath.row==1){
            THMineWalletVC *walletVc = [[THMineWalletVC alloc] init];
             [self.navigationController pushViewController:walletVc animated:YES];
        }
        
    }else if (indexPath.section == 3){
        
        if (indexPath.row == 0) {
            
            THInvitationManageCtl *invitationManage = [[THInvitationManageCtl alloc] init];
            invitationManage.title = _dataArray[indexPath.section][indexPath.row][@"title"];
             [self.navigationController pushViewController:invitationManage animated:YES];
            
        } else if (indexPath.row < 3){
            
            THMyCollectCtl *collect = [[THMyCollectCtl alloc] init];
            collect.title = _dataArray[indexPath.section][indexPath.row][@"title"];
            collect.type = indexPath.row == 2 ? MineGoodsTypeScanHistory : MineGoodsTypeMyAttention;
             [self.navigationController pushViewController:collect animated:YES];
            
        } else if (indexPath.row == 3) {
            THTeCtl *te = [[THTeCtl alloc] init];
            te.title = @"我的晒单";
             [self.navigationController pushViewController:te animated:YES];
        } else if (indexPath.row == 4) {
            
            THMyTaskCtl *taskCtl = [[THMyTaskCtl alloc] init];
            taskCtl.title = _dataArray[indexPath.section][indexPath.row][@"title"];
             [self.navigationController pushViewController:taskCtl animated:YES];
            
        }
        
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return self.collectionView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0) return 67;
	if (indexPath.section == 4) return 150;
	return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 5) {
        return kScreenHeight-kTabBarHeight;
    }
	return CGFLOAT_MIN;
}

#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THGoodsListOfCollectionLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class) forIndexPath:indexPath];
    cell.favModel = self.dataSource[indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 2) {
//        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (UITableView *)tableView {
	if (!_tableView) {
		_tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
		_tableView.delegate = self;
		_tableView.dataSource = self;
		[_tableView registerNib:[UINib nibWithNibName:@"THMineSectionCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMineSectionCell.class)];
		[_tableView registerNib:[UINib nibWithNibName:@"THMineAdCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMineAdCell.class)];
		[_tableView registerClass:[THMineOrderHeaderCell class] forCellReuseIdentifier:NSStringFromClass(THMineOrderHeaderCell.class)];
        _tableView.tableHeaderView = self.headView;
	}
	return _tableView;
}

- (THMineHeaderView *)headView {
	if (_headView == nil) {
		_headView = [[THMineHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,  100+kNaviHeight)];
        kWeakSelf;
		_headView.gotoMotifyInfoPage = ^{
            if ([@"" length]) {
                THUserInfoEditCtl *edit = [[THUserInfoEditCtl alloc] init];
                edit.title = @"个人资料编辑";
                 [weakSelf.navigationController pushViewController:edit animated:YES];
            } else {
                THLoginVC *loginVc = [[THLoginVC alloc] init];
                 [weakSelf.navigationController pushViewController:loginVc animated:YES];
            }
		};
	}
	return _headView;
}


- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenWidth-4)/2, (kScreenWidth-4)/2+80);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = BGColor;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class)];
    }
    return _collectionView;
}

#pragma mark --
- (void)getLocalDataSuccess:(NSArray<NSArray<NSString *> *> *)datas {
    _dataArray = datas;
}


#pragma mark --Navigation
- (void)rightAction:(NSInteger)tag {
    if (tag == 0) {
        //菜单
        [_munuView show];
    } else if (tag == 1) {
        //设置
        [self.navigationController pushViewController:[THSettingCtl new] animated:YES];
    }
}

@end
