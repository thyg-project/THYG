//
//  THClassifyVC.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THClassifyVC.h"
#import "THHomeHeaderItemCell.h"
#import "THClassifyHeaderView.h"
#import "THClassifyItemCell.h"
#import "THSearchView.h"
#import "THSpellGroupCtl.h"
#import "THLimitSpellGroupCtl.h"
#import "THFlashCtl.h"
#import "THScreeningGoodsCtl.h"
#import "THCategoryPresenter.h"

@interface THClassifyVC () <UICollectionViewDelegate, UICollectionViewDataSource, THCategoryProtocol> {
	NSArray <NSArray *>*_itemsArray;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) THSearchView *searchView;

@property (nonatomic, strong) THCategoryPresenter *presenter;

@end

@implementation THClassifyVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THCategoryPresenter alloc] initPresenterWithProtocol:self];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.navigationItem.titleView = ({
        self.searchView = [[THSearchView alloc] initWithFrame:CGRectMake(WIDTH(20),0, kScreenWidth - WIDTH(40),30)];
        self.searchView;
    });
    
    [self.presenter loadLocalizedData];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return _itemsArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _itemsArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	UICollectionViewCell *cell = nil;
	if (indexPath.section < 2) {
		THHomeHeaderItemCell *headerCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THHomeHeaderItemCell.class) forIndexPath:indexPath];
		headerCell.isClassifyItem = YES;
		headerCell.itemDict = _itemsArray[indexPath.section][indexPath.row];
		cell = headerCell;
	
	} else {
		THClassifyItemCell *itemCell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THClassifyItemCell.class) forIndexPath:indexPath];
		cell = itemCell;
	}
	
	return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
	UICollectionReusableView *headerView = nil;
	
	if (kind == UICollectionElementKindSectionHeader) {
		THClassifyHeaderView *headerV = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THClassifyHeaderView.class) forIndexPath:indexPath];
		headerV.title = @[@"精彩活动", @"商品分类",@"地方馆"][indexPath.section];
		headerView = headerV;
	}
	return headerView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            switch (indexPath.row) {
                    //定量团
                case 0: {
                    THLimitSpellGroupCtl *limitSpellGroup = [[THLimitSpellGroupCtl alloc] init];
                    limitSpellGroup.title = _itemsArray[indexPath.section][indexPath.row][@"title"];
                     [self.navigationController pushViewController:limitSpellGroup animated:YES];
                }
                    break;
                    //拼团
                case 1: {
                    THSpellGroupCtl *spellGroup = [[THSpellGroupCtl alloc] init];
                    spellGroup.title = _itemsArray[indexPath.section][indexPath.row][@"title"];
                     [self.navigationController pushViewController:spellGroup animated:YES];
                }
                    break;
                    //秒杀
                case 2: {
                    THFlashCtl *flash = [[THFlashCtl alloc] init];
                    flash.title = _itemsArray[indexPath.section][indexPath.row][@"title"];
                     [self.navigationController pushViewController:flash animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: {
            THScreeningGoodsCtl *screening = [[THScreeningGoodsCtl alloc] init];
            screening.cat_id = [NSString stringWithFormat:@"%@", _itemsArray[indexPath.section][indexPath.row][@"id"]];
            screening.isShowSearchBar = YES;
             [self.navigationController pushViewController:screening animated:YES];
        }
            break;
        case 2: {
        }
            break;
        default:
            break;
    } 
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section < 2) {
        return CGSizeMake(kScreenWidth / 4, WIDTH(76));
    }
	return CGSizeMake(kScreenWidth, WIDTH(180));
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionVertical;
		layout.minimumLineSpacing = 0;
		layout.minimumInteritemSpacing = 0;
		layout.headerReferenceSize = CGSizeMake(kScreenWidth, 44);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = [UIColor whiteColor];
		_collectionView.pagingEnabled = YES;
		[_collectionView registerNib:[UINib nibWithNibName:@"THHomeHeaderItemCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THHomeHeaderItemCell.class)];
		[_collectionView registerNib:[UINib nibWithNibName:@"THClassifyItemCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THClassifyItemCell.class)];
		[_collectionView registerNib:[UINib nibWithNibName:@"THClassifyHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(THClassifyHeaderView.class)];
	}
	return _collectionView;
}

#pragma mark---
- (void)loadLocalizedSuccess:(NSArray<NSArray<NSDictionary *> *> *)data {
    _itemsArray = data;
    [self.collectionView reloadData];
}

@end
