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
#import "THGoodsPageSiftView.h"
#import "THGoodsDetailVC.h"

#import "UISearchBar+FMAdd.h"
#import "THScreeningView.h"
#import "THGoodsModel.h"

#define itemWidth   (kScreenWidth - 3 * 10) * 0.5
#define MenuTableWidth (kScreenWidth-kScreenWidth*0.15)

@interface THScreeningGoodsCtl ()<UISearchBarDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UISearchBar * searchBar;
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UIButton * layoutButton;
@property (nonatomic, strong) THGoodsPageSiftView * siftView;
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
{
    NSMutableDictionary *_siftDict; // 筛选字典 包含品牌和价格区间
    NSInteger _currentSelectIndex; // 当前选择筛选视图的位置
    NSInteger _sectionNum; // 分组
    CGFloat _cellHeight; // cell高度
    UITextField *_searchTextField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self getFilterData];
    [self requestData:NO];
}

#pragma mark - 设置UI界面
- (void)setupUI {
    [self.view addSubview:self.siftView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.screeningView];
    [self.siftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_offset(44);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.siftView.mas_bottom);
    }];
    self.pageIndex = 1;
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex += 1;
        [self requestData:NO];
    }];
    
    self.collectionView.mj_footer.hidden = YES;
    
    if (self.isShowSearchBar) {
        UIView *titleView = [[UIView alloc] init];
        self.searchBar = [[UISearchBar alloc] initWithFrame:titleView.bounds];
        [titleView addSubview:self.searchBar];
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
            if (@available(iOS 9.0, *)) {
                [NSLayoutConstraint activateConstraints:@[
                                                          [self.searchBar.topAnchor constraintEqualToAnchor:titleView.topAnchor],
                                                          [self.searchBar.leftAnchor constraintEqualToAnchor:titleView.leftAnchor constant:-10],
                                                          [self.searchBar.rightAnchor constraintEqualToAnchor:titleView.rightAnchor constant:-10],
                                                          [self.searchBar.bottomAnchor constraintEqualToAnchor:titleView.bottomAnchor]
                                                          ]];
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.searchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        }
        
        self.navigationItem.titleView = titleView;
        self.searchBar.placeholder = @"搜索关键词";
        self.searchBar.barTintColor = [UIColor whiteColor];
        [self.searchBar setImage:[UIImage imageNamed:@"bSearch"]forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        self.searchBar.delegate = self;
        
        for (UIView *subView in [[self.searchBar.subviews lastObject] subviews]) {
            if ([[subView class] isSubclassOfClass:[UITextField class]]) {
                UITextField *textField = (UITextField *)subView;
                textField.font = [UIFont systemFontOfSize:14];
                textField.textColor = GRAY_COLOR(17);
                textField.backgroundColor = BGColor;
                self.searchText.length ? textField.placeholder = self.searchText : nil;
                _searchTextField = textField;
                break;
            }
        }
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.layoutButton];
    
    _siftDict = [NSMutableDictionary dictionaryWithCapacity:0];
    
    [self.dataSource removeAllObjects];
    
    kWeakSelf;
    // 综合 0  销量 1  价格 2  筛选 3
    self.siftView.siftClickBlock = ^(NSInteger idx) {
        //排序类型，有 goods_id（综合），comment_count（评论），sales_sum（销量），shop_price（价格）
        kStrongSelf;
        if (idx != 3) {
            strongSelf.sortParma = (idx == 0) ? @"goods_id" : (idx == 1) ? @"sales_sum" : @"shop_price";
            if (idx == 2) {
                
                if (strongSelf.sort_ascParma && !self.sort_ascParma.length) {
                    strongSelf.sort_ascParma = @"asc";
                } else {
                    if ([strongSelf.sort_ascParma isEqualToString:@"asc"]) {
                        strongSelf.sort_ascParma = @"desc";
                    } else {
                        strongSelf.sort_ascParma = @"asc";
                    }
                }
            }
            
            [strongSelf requestData:YES];
            
        } else {
            [strongSelf.screeningView show];
        }
        
    };
    
    // 筛选回调
    self.screeningView.siftResultBlock = ^(NSString *cat_id, NSString *startPrice, NSString *endPrice) {
        kStrongSelf;
        strongSelf.cat_id = cat_id;
        strongSelf.start_priceParma = startPrice;
        strongSelf.end_priceParma = endPrice;
        [strongSelf requestData:YES];
    };
    
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
        self.searchBar.x = 15;
        self.layoutButton.width = 44;
        self.searchBar.width = kScreenWidth - self.layoutButton.width - 10 * 7 - 8;
        self.searchBar.height = kScreenWidth > self.view.height ? 24 : 30;
        _searchTextField.frame = _searchBar.bounds;
    } else {
        UIView *titleView = self.navigationItem.titleView;
        titleView.x = 10 * 1.5;
        titleView.y = self.view.width > self.view.height ? 3 : 7;
        titleView.width = self.view.width - self.layoutButton.width - titleView.x * 2 - 3;
        titleView.height = self.view.width > self.view.height ? 24 : 30;
    }
    _searchTextField.layer.cornerRadius = self.searchBar.height/2;
    _searchTextField.clipsToBounds = YES;
}

#pragma mark -- 获取筛选条件数据
- (void)getFilterData {

}


- (void)requestData:(BOOL)isClearDataSource {
    
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
    [self requestData:YES];
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
        _collectionView.backgroundColor = BGColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(THHomeHotGoodsCell.class) bundle:nil]  forCellWithReuseIdentifier:NSStringFromClass(THHomeHotGoodsCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(THGoodsTransLayoutCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THGoodsTransLayoutCell.class)];
    }
    return _collectionView;
}

- (UIButton *)layoutButton {
    if (!_layoutButton) {
        _layoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_layoutButton setImage:[UIImage imageNamed:@"liebiao"] forState:UIControlStateNormal];
        [_layoutButton setImage:[UIImage imageNamed:@"liebiaozhanshi"] forState:UIControlStateSelected];
        [_layoutButton addTarget:self action:@selector(changeLayout:) forControlEvents:UIControlEventTouchUpInside];
        _layoutButton.frame = CGRectMake(0, 0, 44, 44);
    }
    return _layoutButton;
}

- (THGoodsPageSiftView *)siftView {
    if (!_siftView) {
        _siftView = [[THGoodsPageSiftView alloc] initWithFrame:CGRectZero];
    }
    return _siftView;
}

- (THScreeningView *)screeningView
{
    if (!_screeningView) {
        _screeningView = [[THScreeningView alloc] init];
    }
    return _screeningView;
}

- (NSArray *)categoryData {
    if (!_categoryData) {
        _categoryData = [NSArray array];
    }
    return _categoryData;
}

@end
