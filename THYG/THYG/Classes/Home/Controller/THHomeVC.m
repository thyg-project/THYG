//
//  THHomeVC.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeVC.h"
#import "THGoodsDetailVC.h"
#import "THHomeHeaderView.h"
#import "THHomeSectionHead.h"
#import "THHomeMallActivityCell.h"
#import "THGoodsListOfCollectionLayoutCell.h"
#import "THScreeningGoodsCtl.h"
#import "THMineShareQRCodeVC.h"
#import "THMyCollectCtl.h"
#import "THFlashCtl.h"
#import "THSpellGroupCtl.h"
#import "THLimitSpellGroupCtl.h"
#import "THGoodsModel.h"
#import "THFavouriteGoodsModel.h"
#import "THMyTeMoneyCtl.h"
#import "THMyMessageCtl.h"
#import "THMenuView.h"
#import "THScanQRCodeVC.h"
#import "THButton.h"
#import "THHomePresenter.h"
#import "THTeInfoViewController.h"
#import "THCouponCenterViewController.h"
#import "THYNPCViewController.h"
#import "THClassifyVC.h"

@interface THHomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, THHomeProtocol, THMemuViewDelegate, THScanResultDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray <THFavouriteGoodsModel *>*dataSource;
@property (nonatomic, strong) THMenuView *menuView;
@property (nonatomic, strong) THHomePresenter *presenter;
@end

@implementation THHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray new];
    _presenter = [[THHomePresenter alloc] initPresenterWithProtocol:self];
    [self setTools];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.titleView = ({
        UIButton *searchButton = [THUIFactory buttonWithTitle:@"搜索" image:@"" selectedImage:@"" fontSize:13 textColor:RGB(222,222,222) bgColor:[UIColor whiteColor] borderColor:nil radius:4 target:self action:@selector(searchClick)];
        searchButton.frame = CGRectMake(0,0, kScreenWidth,30);
        searchButton.layer.cornerRadius = 15;
        searchButton.clipsToBounds = YES;
        searchButton;
    });
    [self addMuneView];
    kWeakSelf;
    [self.collectionView addRefreshHeaderAutoRefresh:NO animation:YES refreshBlock:^{
        kStrongSelf;
        [strongSelf.presenter resetRefreshState];
        [strongSelf.presenter goodsFavourite];
    }];
    [self.collectionView addRefreshFooterAutomaticallyRefresh:NO refreshComplate:^{
        kStrongSelf;
        [strongSelf.presenter goodsFavourite];
    }];
}

- (void)addMuneView {
    _menuView = [THMenuView new];
    self.menuView.data = @[@"推广二维码",@"我的消息",@"关注"];
    _menuView.delegate = self;
    [self.view addSubview:self.menuView];
}

#pragma mark - 菜单
- (void)menuAction {
    if (CGRectGetHeight(self.menuView.visibleRect) > 0) {
        [self.menuView dismiss];
    } else {
        [self.menuView show];
    }
    
}

- (void)searchClick {
    THScreeningGoodsCtl *search = [[THScreeningGoodsCtl alloc] init];
     [self.navigationController pushViewController:search animated:YES];
}

#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
	return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        THHomeMallActivityCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:@"THHomeMallActivityCell" forIndexPath:indexPath];
        cell.selectItemBlock = ^(NSInteger item) {
            if (item == 1) {
                
            }
        };
        
        return cell;
    } else {
        THGoodsListOfCollectionLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class) forIndexPath:indexPath];
        cell.favModel = self.dataSource[indexPath.item];
        return cell;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *reusableview = nil;
	if (kind == UICollectionElementKindSectionHeader) {
        if (indexPath.section==0) {
            THHomeHeaderView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(THHomeHeaderView.class) forIndexPath:indexPath];
            headerV.clickMenuItem = ^(NSInteger itemIndex, THHomeHeaderItemModel *item) {
                if (itemIndex == 1) {
                    [self.navigationController pushViewController:[THTeInfoViewController new] animated:YES];
                } else if (itemIndex == 2) {
                    [self.navigationController pushViewController:THCouponCenterViewController.new animated:YES];
                } else if (itemIndex == 4) {
                    [self.navigationController pushViewController:[THYNPCViewController new] animated:YES];
                } else if (itemIndex == 5) {
                    THYNPCViewController *vc = [THYNPCViewController new];
                    vc.controllerType = ViewControllerType_SLYS;
                    [self.navigationController pushViewController:vc animated:YES];
                } else if (itemIndex == 7) {
                    THClassifyVC *vc = [THClassifyVC new];
                    [self.navigationController pushViewController:vc animated:YES];
                } else if (itemIndex == 6) {
                    //批量团购
                    [self.navigationController pushViewController:THSpellGroupCtl.new animated:YES];
                }
            };
            reusableview = headerV;
        } else {
            THHomeSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"THHomeSectionHead" forIndexPath:indexPath];
            sectionHead.backgroundColor = [UIColor clearColor];
            reusableview = sectionHead;
        }
		
	}
	return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section > 0 ) {
        THGoodsDetailVC *detailVc = [[THGoodsDetailVC alloc] init];
        THFavouriteGoodsModel *model = self.dataSource[indexPath.item];
        detailVc.goodsId = model.goods_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(kScreenWidth , WIDTH(264));
    }
    CGFloat width = (kScreenWidth-16)/2;
	return CGSizeMake(width, width + 80);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
	if (section == 0) return CGSizeMake(kScreenWidth, WIDTH(375));
    if (section == 1) return CGSizeMake(kScreenWidth, 33 + 16);
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
	return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 1) {
       return UIEdgeInsetsMake(0, 8, 0, 8);
    }
	return UIEdgeInsetsZero;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsVerticalScrollIndicator = NO;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
		_collectionView.backgroundColor = kBackgroundColor;
		[_collectionView registerClass:[THHomeMallActivityCell class] forCellWithReuseIdentifier:@"THHomeMallActivityCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"THGoodsListOfCollectionLayoutCell" bundle:nil] forCellWithReuseIdentifier:@"THGoodsListOfCollectionLayoutCell"];
		[_collectionView registerClass:[THHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"THHomeHeaderView"];
        [_collectionView registerClass:THHomeSectionHead.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"THHomeSectionHead"];
	}
	return _collectionView;
}

- (void)setTools {
    THButton *left = [[THButton alloc] initWithButtonType:THButtonType_imageTop];
    left.image = [UIImage imageNamed:@"扫一扫.png"];
    left.frame = CGRectMake(0, 0, 40, 44);
    left.margen = 4;
    left.title = @"扫一扫";
    left.font = Font(9);
    left.textColor = UIColor.whiteColor;
    [left addTarget:self action:@selector(scanAction)];
    THButton *right = [[THButton alloc] initWithButtonType:THButtonType_imageTop];
    right.image = [UIImage imageNamed:@"更多.png"];
    right.textColor = [UIColor whiteColor];
    [right addTarget:self action:@selector(menuAction)];
    right.frame = CGRectMake(0, 0, 40, 44);
    right.margen = 4;
    right.title = @"更多";
    right.font = Font(9);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
}

- (void)scanAction {
    // 检查权限
    [self.presenter checkCameraState];
}

#pragma mark --
- (void)authCameraFailed {
    UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相机权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
    [controller addAction:aciton];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancel];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)authCameraSuccess {
    THScanQRCodeVC *scanVc = [[THScanQRCodeVC alloc] init];
    scanVc.delegate = self;
    [self.navigationController pushViewController:scanVc animated:YES];
}

#pragma mark --THMenuViewDelegate
- (void)menuViewDismiss:(THMenuView *)menuView {
    [menuView dismiss];
}

- (void)menuView:(THMenuView *)menuView didSelectedIndex:(NSInteger)index {
    [menuView dismiss];
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

- (void)scanResult:(NSString *)url scanType:(THScanType)scanType {
    
}

- (void)share:(THScanQRCodeVC *)container {
    [container.navigationController pushViewController:[THMineShareQRCodeVC new] animated:YES];
}

- (void)loadFavouriteGoodsFailed:(NSDictionary *)errorInfo {
    [self.collectionView endRefresh];
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)loadFavouriteGoodsSuccess:(NSArray<THFavouriteGoodsModel *> *)list {
    [self.collectionView endRefresh];
    [self.dataSource addObjectsFromArray:list];
    [self.collectionView reloadData];
}

- (void)resetDataSource {
    [_dataSource removeAllObjects];
}

@end
