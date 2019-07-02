//
//  THFlashCtl.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THFlashCtl.h"
#import "THGoodsDetailVC.h"
#import "THSpellGroupSectionHead.h"
#import "THFlashCell.h"
#import "THMoreLimitSpellGroupCell.h"
#import "THSpellGroupHead.h"
#import "THFlashSaleModel.h"
#import "UIScrollView+MJRefreshExtension.h"

@interface THFlashCtl () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, YYRefreshExtensionDelegate>
@property (nonatomic, strong) NSMutableArray *mvpArray;
@property (nonatomic, strong) NSMutableArray *listArray;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) THSpellGroupHead *headView;
@end

@implementation THFlashCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"秒杀";
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:RGB(59, 59, 59)] forBarMetrics:UIBarMetricsDefault];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headView.mas_bottom);
    }];
    [self.collectionView addHeaderWithHeaderClass:nil beginRefresh:NO delegate:self animation:YES];
    [self.collectionView addFooterWithFooterClass:nil automaticallyRefresh:NO delegate:self];
    
}

#pragma mark - YYRefreshExtensionDelegate
- (void)onRefreshing:(id)control {
    [self getFlashSaleListWithPageNum:1 isHeader:YES];
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    [self getFlashSaleListWithPageNum:pageNum.integerValue isHeader:NO];
}

#pragma mark - 秒杀
- (void)getFlashSaleListWithPageNum:(NSInteger)pageNum isHeader:(BOOL)isHeader {
    
}

#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.mvpArray.count;
    }
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        THFlashCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THFlashCell.class) forIndexPath:indexPath];
        cell.flashModel = self.mvpArray[indexPath.item];
        return cell;
    }
    
    THMoreLimitSpellGroupCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THMoreLimitSpellGroupCell.class) forIndexPath:indexPath];
    cell.flashModel = self.listArray[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        THSpellGroupSectionHead *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(THSpellGroupSectionHead.class) forIndexPath:indexPath];
        headerV.sectionTitle = @[@"秒杀最低价MVP",@"更多精彩秒杀"][indexPath.section];
        reusableview = headerV;
        
    } else {
        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
    }
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    THGoodsDetailVC *goodDetailVc = [[THGoodsDetailVC alloc] init];
    THFlashSaleModel *flashModel = self.listArray[indexPath.item];
    goodDetailVc.goodsId = flashModel.goods_id;
    [self.navigationController pushViewController:goodDetailVc animated:YES];
}


#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return CGSizeMake((kScreenWidth-4)/2, (kScreenWidth-4)/2+140);
    return CGSizeMake(kScreenWidth, 130);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 45);
}

#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(kScreenWidth, 10);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = BGColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"THFlashCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THFlashCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:@"THMoreLimitSpellGroupCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THMoreLimitSpellGroupCell.class)];
        
        [_collectionView registerClass:[THSpellGroupSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THSpellGroupSectionHead.class)];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
        
        
    }
    return _collectionView;
}

- (THSpellGroupHead *)headView {
    if (!_headView) {
        _headView = [[THSpellGroupHead alloc] initWithFrame:CGRectZero];
    }
    return _headView;
}

- (NSMutableArray *)mvpArray {
    if (!_mvpArray) {
        _mvpArray = [NSMutableArray array];
    }
    return _mvpArray;
}

- (NSArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
