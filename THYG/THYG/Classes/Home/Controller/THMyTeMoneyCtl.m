//
//  THMyTeMoneyCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyTeMoneyCtl.h"
#import "THTeMoneyHead.h"
#import "THGoodsListOfCollectionLayoutCell.h"
#import "THHomeSectionHead.h"
#import "THFavouriteGoodsModel.h"
#import "THHomePresenter.h"

@interface THMyTeMoneyCtl ()<UICollectionViewDelegate,UICollectionViewDataSource, THHomeProtocol>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) THHomePresenter *presenter;

@end

@implementation THMyTeMoneyCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THHomePresenter alloc] initPresenterWithProtocol:self];
    self.navigationItem.title = @"我的特币";
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view);
     }];
    kWeakSelf;
    [self.collectionView addRefreshHeaderAutoRefresh:YES animation:YES refreshBlock:^{
        kStrongSelf;
        [strongSelf.presenter resetRefreshState];
        [strongSelf.presenter goodsFavourite];
    }];
    [self.collectionView addRefreshFooterAutomaticallyRefresh:NO refreshComplate:^{
        kStrongSelf;
        [strongSelf.presenter goodsFavourite];
    }];
}

#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return !section ? 0 : self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        
        
        return nil;
        
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
            THTeMoneyHead *head = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THTeMoneyHead.class) forIndexPath:indexPath];
            reusableview = head;
            
        } else {
            THHomeSectionHead *sectionHead = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(THHomeSectionHead.class) forIndexPath:indexPath];
            reusableview = sectionHead;
        }
        
    }
    return reusableview;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return CGSizeMake(kScreenWidth , WIDTH(264));
    return CGSizeMake((kScreenWidth-4)/2, (kScreenWidth-4)/2+80);
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) return CGSizeMake(kScreenWidth, WIDTH(150));
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
        
        [_collectionView registerNib:[UINib nibWithNibName:@"THGoodsListOfCollectionLayoutCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class)];
        [_collectionView registerClass:THTeMoneyHead.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"THTeMoneyHead"];
        [_collectionView registerClass:THHomeSectionHead.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"THHomeSectionHead"];
    }
    return _collectionView;
}

#pragma mark ---
- (void)loadFavouriteGoodsFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)loadFavouriteGoodsSuccess:(NSArray *)list {
    
}

@end
