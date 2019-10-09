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
#import "THHomeProtocol.h"

@interface THHomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, THHomeProtocol, THMemuViewDelegate, THScanResultDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) THMenuView *menuView;
@property (nonatomic, strong) THHomePresenter *presenter;
@end

@implementation THHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [self.collectionView addRefreshHeaderAutoRefresh:NO animation:YES refreshBlock:^{
        
    }];
    [self.collectionView addRefreshFooterAutomaticallyRefresh:NO refreshComplate:^{
        
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
        THHomeMallActivityCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THHomeMallActivityCell.class) forIndexPath:indexPath];
        cell.selectItemBlock = ^(NSInteger item) {
            if (item == 0) {
                THFlashCtl *flash = [[THFlashCtl alloc] init];
                 [self.navigationController pushViewController:flash animated:YES];
            } else if (item == 1) {
                THSpellGroupCtl *spellGroup = [[THSpellGroupCtl alloc] init];
                 [self.navigationController pushViewController:spellGroup animated:YES];
            } else {
                THScreeningGoodsCtl *screenGoods = [[THScreeningGoodsCtl alloc] init];
                if (item == 2) {
                    screenGoods.title = @"每日推荐";
                } else if (item == 3){
                    screenGoods.title = @"必买清单";
                }
                 [self.navigationController pushViewController:screenGoods animated:YES];
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
              
                switch (itemIndex) {
                    case 0: {
                        THMyTeMoneyCtl *te = [[THMyTeMoneyCtl alloc] init];
                         [self.navigationController pushViewController:te animated:YES];
                    }
                        break;
                    case 1: {
                        THGoodsDetailVC *detailVc = [[THGoodsDetailVC alloc] init];
                       
                        detailVc.goodsId = @"";
                        [self.navigationController pushViewController:detailVc animated:YES];
                        
                    }
                        break;
                    case 2: {
                        

                    }
                        break;
                    case 3: {
                        THLimitSpellGroupCtl *limitSpellGroup = [[THLimitSpellGroupCtl alloc] init];
                        limitSpellGroup.title = item.name;
                         [self.navigationController pushViewController:limitSpellGroup animated:YES];
                    }
                        break;
                    case 4: {
                        THSpellGroupCtl *spellGroup = [[THSpellGroupCtl alloc] init];
                        spellGroup.title = item.name;
                         [self.navigationController pushViewController:spellGroup animated:YES];
                    }
                        break;
                    case 5: {
                        THFlashCtl *flash = [[THFlashCtl alloc] init];
                        flash.title = item.name;
                         [self.navigationController pushViewController:flash animated:YES];
                    }
                        break;
                }
            };
            reusableview = headerV;
        } else {
            THHomeSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(THHomeSectionHead.class) forIndexPath:indexPath];
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
	if (indexPath.section == 0) return CGSizeMake(kScreenWidth , WIDTH(264));
	return CGSizeMake((kScreenWidth-4)/2, (kScreenWidth-4)/2+80);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
	if (section == 0) return CGSizeMake(kScreenWidth, WIDTH(283));
    if (section == 1) return CGSizeMake(kScreenWidth, 45);
    return CGSizeZero;
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
	return CGSizeZero;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	if (section == 2) {
		return UIEdgeInsetsMake(0, 10, 10, 10);
	}
	return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 2;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==1) {
        return 1;
    }
    return CGFLOAT_MIN;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsVerticalScrollIndicator = NO;
		_collectionView.backgroundColor = kBackgroundColor;
		
		[_collectionView registerClass:[THHomeMallActivityCell class] forCellWithReuseIdentifier:NSStringFromClass(THHomeMallActivityCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:@"THGoodsListOfCollectionLayoutCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class)];
		
		[_collectionView registerClass:[THHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THHomeHeaderView.class)];
        [_collectionView registerClass:THHomeSectionHead.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"THHomeSectionHead"];
	}
	return _collectionView;
}

- (void)setTools {
    THButton *left = [[THButton alloc] initWithButtonType:THButtonType_imageTop];
    left.image = [UIImage imageNamed:@"dingbu-saoyisao"];
    left.frame = CGRectMake(0, 0, 40, 44);
    left.margen = 4;
    left.title = @"扫一扫";
    left.font = Font(9);
    left.textColor = UIColor.whiteColor;
    [left addTarget:self action:@selector(scanAction)];
    THButton *right = [[THButton alloc] initWithButtonType:THButtonType_imageTop];
    right.image = [UIImage imageNamed:@"dingbugengduo"];
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

@end
