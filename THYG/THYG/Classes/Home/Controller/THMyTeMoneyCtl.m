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
#import "UIScrollView+MJRefreshExtension.h"

@interface THMyTeMoneyCtl ()<UICollectionViewDelegate,UICollectionViewDataSource, YYRefreshExtensionDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THMyTeMoneyCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的特币";
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view);
     }];
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
    [self.collectionView addHeaderWithHeaderClass:nil beginRefresh:YES delegate:self animation:YES];
    [self.collectionView addFooterWithFooterClass:nil automaticallyRefresh:NO delegate:self];
}
- (void)onRefreshing:(id)control {
    [self requestNetWorkingWithPageNum:1 isHeader:YES];
}

- (void)onLoadingMoreData:(id)control pageNum:(NSNumber *)pageNum {
    [self requestNetWorkingWithPageNum:pageNum.integerValue isHeader:NO];
}

#pragma mark - 猜你喜欢
- (void)requestNetWorkingWithPageNum:(NSInteger)pageNum isHeader:(BOOL)isHeader {
    /*
    [THHUD show];
    [THNetworkTool POST:API(@"/Goods/favouriteGoods") parameters:@{@"page":@(pageNum)} completion:^(id responseObject, NSDictionary *allResponseObject) {
        [THHUD dismiss];
        NSArray *tempArr = [THFavouriteGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"info"]];
        
        if (tempArr.count) {
            if (isHeader) {
                [self.collectionView endHeaderRefreshWithChangePageIndex:YES];
                [self.dataSourceArray removeAllObjects];
                [self.dataSourceArray addObjectsFromArray:tempArr];
                
            } else {
                [self.collectionView endFooterRefreshWithChangePageIndex:YES];
                if (tempArr.count) {
                    [self.dataSourceArray addObjectsFromArray:tempArr];
                }else {
                    [self.collectionView noMoreData];
                }
            }
            
        } else {
            NSLog(@"请求失败");
            if (isHeader) {
                [self.collectionView endHeaderRefreshWithChangePageIndex:NO];
            }else {
                [self.collectionView endFooterRefreshWithChangePageIndex:NO];
            }
        }
        [self.collectionView reloadData];
    }];
    */
}


#pragma mark - collectionView 代理 & 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    
//    if (SECTION > 0 ) {
//
//    }
//
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
//        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    if (section==1) {
        return 2;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
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
        
        [_collectionView registerNib:[UINib nibWithNibName:@"THGoodsListOfCollectionLayoutCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THGoodsListOfCollectionLayoutCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:@"THTeMoneyHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THTeMoneyHead.class)];
        [_collectionView registerNib:[UINib nibWithNibName:@"THHomeSectionHead" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THHomeSectionHead.class)];
//
    }
    return _collectionView;
}

@end
