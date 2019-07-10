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
#import "THFlashCtl.h"
#import "THMyTeMoneyCtl.h"
#import "THMyMessageCtl.h"
#import "THScreeningGoodsCtl.h"
#import "THHomeShowMenuView.h"
#import "THAVCaptureSessionManager.h"
#import "THScanQRCodeVC.h"
#import "UIScrollView+MJRefreshExtension.h"

@interface THHomeVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,YYRefreshExtensionDelegate>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) THHomeShowMenuView *menuView;
@end

@implementation THHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTools];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.titleView = ({
        UIButton *searchButton = [THUIFactory buttonWithTitle:@"搜索" image:@"" selectedImage:@"" fontSize:13 textColor:GRAY_COLOR(222) bgColor:[UIColor whiteColor] borderColor:nil radius:4 target:self action:@selector(searchClick)];
        searchButton.frame = CGRectMake(0,0, kScreenWidth,30);
        searchButton.layer.cornerRadius = 15;
        searchButton.clipsToBounds = YES;
        [searchButton layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:8];
        searchButton;
    });
    _menuView = [THHomeShowMenuView new];
    self.menuView.data = @[@"推广二维码",@"我的消息",@"关注"];
    [self.view addSubview:self.menuView];
    
    [self.collectionView addHeaderWithHeaderClass:nil beginRefresh:NO delegate:self animation:YES];
    [self.collectionView addFooterWithFooterClass:nil automaticallyRefresh:NO delegate:self];

}

#pragma mark - YYRefreshExtensionDelegate
- (void)onRefreshing:(id)control {
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    [self requestNetWorkingWithPageNum:pageNum.integerValue isHeader:NO];
}

#pragma mark - 猜你喜欢
- (void)requestNetWorkingWithPageNum:(NSInteger)pageNum isHeader:(BOOL)isHeader {
    
}

#pragma mark - 菜单
- (void)menuAction {
    [self.menuView show];
    kWeakSelf
    self.menuView.selectedAction = ^(NSInteger index) {
        if (index == 0) {//我的二维码
            THMineShareQRCodeVC *shareVc = [[THMineShareQRCodeVC alloc] init];
             [weakSelf.navigationController pushViewController:shareVc animated:YES];
            
        } else if (index == 1) {//我的消息
            THMyMessageCtl *myMessage = [[THMyMessageCtl alloc] init];
             [weakSelf.navigationController pushViewController:myMessage animated:YES];
        } else {//我的关注
            THMyCollectCtl *collectVc = [[THMyCollectCtl alloc] init];
             [weakSelf.navigationController pushViewController:collectVc animated:YES];
        }
    };
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
                }else if (item == 3){
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
            headerV.clickMenuItem = ^(NSInteger itemIndex, NSString *itemName) {
              
                switch (itemIndex) {
                    case 0: {
                        THMyTeMoneyCtl *te = [[THMyTeMoneyCtl alloc] init];
                         [self.navigationController pushViewController:te animated:YES];
                    }
                        break;
                    case 1: {
                        
                    }
                        break;
                    case 2: {
                        

                    }
                        break;
                    case 3: {
                        THLimitSpellGroupCtl *limitSpellGroup = [[THLimitSpellGroupCtl alloc] init];
                        limitSpellGroup.title = itemName;
                         [self.navigationController pushViewController:limitSpellGroup animated:YES];
                    }
                        break;
                    case 4: {
                        THSpellGroupCtl *spellGroup = [[THSpellGroupCtl alloc] init];
                        spellGroup.title = itemName;
                         [self.navigationController pushViewController:spellGroup animated:YES];
                    }
                        break;
                    case 5: {
                        THFlashCtl *flash = [[THFlashCtl alloc] init];
                        flash.title = itemName;
                         [self.navigationController pushViewController:flash animated:YES];
                    }
                        break;
                        
                    default:
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
		_collectionView.backgroundColor = BGColor;
		
		[_collectionView registerClass:[THHomeMallActivityCell class] forCellWithReuseIdentifier:NSStringFromClass(THHomeMallActivityCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:@"THGoodsListOfCollectionLayoutCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class)];
		
		[_collectionView registerClass:[THHomeHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THHomeHeaderView.class)];
        [_collectionView registerNib:[UINib nibWithNibName:@"THHomeSectionHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THHomeSectionHead.class)];
    
	}
	return _collectionView;
}

- (void)setTools {
    UIButton *left = [THUIFactory buttonWithImage:@"dingbu-saoyisao" selectedImage:@"dingbu-saoyisao" target:self action:@selector(scanAction)];
    left.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    left.frame = CGRectMake(0, 0, 40, 44);
    [left setTitle:@"扫一扫" forState:UIControlStateNormal];
    left.titleLabel.font = Font(9);
    [left layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
    UIButton *right = [THUIFactory buttonWithImage:@"dingbugengduo" selectedImage:@"dingbugengduo" target:self action:@selector(menuAction)];
    right.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    right.frame = CGRectMake(0, 0, 40, 44);
    [right setTitle:@"更多" forState:UIControlStateNormal];
    right.titleLabel.font = Font(9);
    [right layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:4];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:left];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:right];
}

- (void)scanAction {
    
    // 检查权限
    [THAVCaptureSessionManager checkAuthorizationStatusForCameraWithGrantBlock:^{
        THScanQRCodeVC *scanVc = [[THScanQRCodeVC alloc] init];
        [self.navigationController pushViewController:scanVc animated:YES];
    } DeniedBlock:^{
        UIAlertAction *aciton = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }];
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"权限未开启" message:@"您未开启相机权限，点击确定跳转至系统设置开启" preferredStyle:UIAlertControllerStyleAlert];
        [controller addAction:aciton];
        [self presentViewController:controller animated:YES completion:nil];
    }];
    
}


@end
