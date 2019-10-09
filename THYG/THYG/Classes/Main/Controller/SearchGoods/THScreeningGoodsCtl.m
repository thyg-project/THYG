//
//  THScreeningGoodsCtl.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THScreeningGoodsCtl.h"
#import "THHomeHotGoodsCell.h"
#import "THGoodsTransLayoutCell.h"
#import "THGoodsDetailVC.h"
#import "THButton.h"
#import "UISearchBar+FMAdd.h"
#import "THScreeningView.h"
#import "THGoodsModel.h"
#import "THNavigationView.h"
#import "THFilterView.h"

#define itemWidth   (kScreenWidth - 3 * 10) * 0.5
#define MenuTableWidth (kScreenWidth-kScreenWidth*0.15)

@interface THScreeningGoodsCtl ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource, THNaviagationViewDelegate, THFilterViewDelegate, THScreeningViewDelegate> {
    NSMutableDictionary *_siftDict; // 筛选字典 包含品牌和价格区间
}
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) THFilterView *filterView;
@property (nonatomic, strong) THScreeningView *screeningView;
@property (nonatomic, copy) NSString *sortParma;
@property (nonatomic, copy) NSString *sort_ascParma;
@property (nonatomic, copy) NSString *start_priceParma;
@property (nonatomic, copy) NSString *end_priceParma;
@property (nonatomic, copy) NSArray *categoryData;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger pageIndex;

//是否是横向布局
@property (nonatomic) BOOL isTransLayout;
@end

@implementation THScreeningGoodsCtl

- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

#pragma mark - 设置UI界面
- (void)setupUI {
    THNavigationView *navigationView = [THNavigationView new];
    navigationView.backgroundColor = RGB(213, 0, 27);
    [self.view addSubview:navigationView];
    self.searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 60 * 2, 30)];;
    self.searchTextField.layer.cornerRadius = 15;
    self.searchTextField.layer.masksToBounds = YES;
    navigationView.delegate = self;
    navigationView.titleView = self.searchTextField;
    navigationView.rightButtonImage = [UIImage imageNamed:@"liebiao"];
    navigationView.rightSelectedImage = [UIImage imageNamed:@"liebiaozhanshi"];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kNaviHeight);
    }];
    _filterView = [[THFilterView alloc] initWithDatas:@[@"综合",@"销量",@"价格",@"筛选"]];
    _filterView.delegate = self;
    //down_thrAngle
    [_filterView setImage:[UIImage imageNamed:@"shangxiajiantou"] selectedImage:[UIImage imageNamed:@"up_thrAngle"] index:2];
    [_filterView setImage:[UIImage imageNamed:@"shaixuan"] selectedImage:nil index:3];
    _filterView.normalColor = RGB(80, 80, 80);
    _filterView.selectedColor = RGB(213, 0, 27);
    [self.view addSubview:self.filterView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.screeningView];
    [self.filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(navigationView.mas_bottom);
        make.height.mas_offset(44);
    }];
    _filterView.imageMargenToText = 10;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.filterView.mas_bottom);
    }];
    [self.screeningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.view);
        make.width.mas_equalTo(kScreenWidth);
        make.left.equalTo(self.view).offset(kScreenWidth);
    }];
    self.pageIndex = 1;
    self.searchTextField.textColor = RGB(17, 17, 17);
     self.searchTextField.placeholder = @"搜索关键词";
//    self.searchTextField.addExtraCancelButton = YES;
//    self.searchBar.lensImage = [UIImage imageNamed:@"bSearch"];
//    self.searchBar.cancelButtonImage = [UIImage imageNamed:@"bSearch"];
    self.searchTextField.backgroundColor = kBackgroundColor;
//    self.searchBar.
//    [self.searchBar setImage:[UIImage imageNamed:@"bSearch"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//    self.searchBar.delegate = self;
//    self.searchBar.text = self.searchText;
    self.searchTextField.font = [UIFont systemFontOfSize:14];
    
    _siftDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [self.dataSource removeAllObjects];
    
}

#pragma mark -- 添加购物车
- (void)addCart:(THGoodsModel *)goodsModel {
    
}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THGoodsModel *goodsModel = self.dataSource[indexPath.row];
    if (self.isTransLayout) {
        THGoodsTransLayoutCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THGoodsTransLayoutCell.class) forIndexPath:indexPath];
        cell.goodsModel = goodsModel;
        cell.addCartAction = ^{
            
            [self addCart:goodsModel];
        };
        return cell;
    }
    THHomeHotGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THHomeHotGoodsCell.class) forIndexPath:indexPath];
    cell.goodsModel = goodsModel;
    cell.addCartAction = ^{
        [self addCart:goodsModel];
    };
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    THGoodsModel *goodsModel = self.dataSource[indexPath.row];
    THGoodsDetailVC *detail = [[THGoodsDetailVC alloc]init];
    detail.goodsId = goodsModel.goods_id;
    [self.navigationController pushViewController:detail animated:YES];
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (_isTransLayout) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (self.isTransLayout) {
        return 0;
    }
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (self.isTransLayout) {
        return 0;
    }
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isTransLayout) {
        return CGSizeMake(kScreenWidth, 120);
    }
    return CGSizeMake(itemWidth, 260);
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
#if 0
    KBSearchVC *searchVc = [[KBSearchVC alloc] init];
    searchVc.searchType = self.searchType;
    searchVc.searchText = self.searchText;
    [self presentVC:searchVc];
    return YES;
#endif
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar endEditing:YES];
    self.searchText = searchBar.text;
    [self.dataSource removeAllObjects];
    
}

#pragma mark - 切换布局
- (void)changeLayout:(UIButton *)button {
    button.selected = !button.selected;
    self.isTransLayout = button.selected;
}

- (void)setIsTransLayout:(BOOL)isTransLayout {
    _isTransLayout = isTransLayout;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout*layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, kScreenWidth, kScreenHeight-kNaviHeight-44) collectionViewLayout:layout];
        _collectionView.backgroundColor = kBackgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"THHomeHotGoodsCell" bundle:nil]  forCellWithReuseIdentifier:@"THHomeHotGoodsCell"];
        [_collectionView registerNib:[UINib nibWithNibName:@"THGoodsTransLayoutCell" bundle:nil] forCellWithReuseIdentifier:@"THGoodsTransLayoutCell"];
    }
    return _collectionView;
}

- (THScreeningView *)screeningView {
    if (!_screeningView) {
        _screeningView = [[THScreeningView alloc] init];
        _screeningView.delegate = self;
    }
    return _screeningView;
}

- (void)back:(THNavigationView *)navigationView {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction:(NSInteger)index container:(THNavigationView *)navigationView {
    navigationView.rightBarButton.selected = !navigationView.rightBarButton.selected;
}

- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
    // 综合 0  销量 1  价格 2  筛选 3
    if (index != 3) {
        self.sortParma = (index == 0) ? @"goods_id" : (index == 1) ? @"sales_sum" : @"shop_price";
        if (index == 2) {
            
            if (self.sort_ascParma && !self.sort_ascParma.length) {
                self.sort_ascParma = @"asc";
            } else {
                if ([self.sort_ascParma isEqualToString:@"asc"]) {
                    self.sort_ascParma = @"desc";
                } else {
                    self.sort_ascParma = @"asc";
                }
            }
        }
        
    } else {
        [self.screeningView showInView:self.view];
    }
}

- (void)screenResultContainer:(THScreeningView *)container catId:(NSString *)catId startProce:(NSString *)startPrice endPrice:(NSString *)endPrice {
    self.cat_id = catId;
    self.start_priceParma = startPrice;
    self.end_priceParma = endPrice;
}

@end
