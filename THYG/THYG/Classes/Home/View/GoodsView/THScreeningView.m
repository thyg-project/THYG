//
//  THScreeningView.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THScreeningView.h"
#import "THSingleLabelCell.h"
#import "THScreeningPriceCell.h"

static CGFloat const kLeftSpace = 40;
static CGFloat const kSpaceWidth = 10;
static CGFloat const kRowNumbers = 4;

@interface THScreeningView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    NSString *_catId, *_startPrice, *_endPrice;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;

@end

@implementation THScreeningView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight-kNaviHeight);
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self addSubview:self.collectionView];
        [self addSubview:self.topView];
        [self addSubview:self.bottomView];
        [self addTarget:self action:@selector(dismissMasView) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)buttomButtonClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            // 重置选择项
            _catId = _startPrice = _endPrice = @"";
            [self.collectionView reloadData];
            break;
        case 1: {
            //执行回调事件
            !self.siftResultBlock?:self.siftResultBlock(_catId, _startPrice, _endPrice);
            [self dismissMasView];
        }
            break;
        default:
            break;
    }
}

- (void)show {
    self.left = 0;
    [UIView animateWithDuration:0.3 animations:^{
       
        self.collectionView.left = kLeftSpace;
        self.topView.left = kLeftSpace;
        self.bottomView.left = kLeftSpace;
        
    }];
}

- (void)dismissMasView {
    [UIView animateWithDuration:0.3 animations:^{
        
        self.collectionView.left = kScreenWidth;
        self.topView.left = kScreenWidth;
        self.bottomView.left = kScreenWidth;
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.left = kScreenWidth;
    });
}

- (void)setDataArray:(NSArray<NSDictionary *> *)dataArray {
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

#pragma mark - collectionView 数据源代理方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        THScreeningPriceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THScreeningPriceCell.class) forIndexPath:indexPath];
        cell.resetValue = YES;
        cell.siftPriceBlock = ^(NSString *startPrice, NSString *endPrice) {
            NSLog(@"startPrice%@, endPrice%@", startPrice, endPrice);
            _startPrice = startPrice;
            _endPrice = endPrice;
        };
        
        return cell;
    }
    THSingleLabelCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THSingleLabelCell.class) forIndexPath:indexPath];
    cell.contentView.backgroundColor = GRAY_COLOR(234);
    cell.singleLabel.text = self.dataArray[indexPath.row][@"mobile_name"];
    if ([collectionView.indexPathsForSelectedItems containsObject:indexPath]) {
        cell.isSelected = YES;
    }else{
        cell.isSelected = NO;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        [[collectionView visibleCells] enumerateObjectsUsingBlock:^(UICollectionViewCell * cell, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([cell isKindOfClass:[THSingleLabelCell class]]) {
                ((THSingleLabelCell *)cell).isSelected = NO;
            }
        }];
        
        THSingleLabelCell *cell = (THSingleLabelCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.isSelected = YES;

        _catId = self.dataArray[indexPath.row][@"id"];
        NSLog(@"cat_id %@", _catId);
        
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return CGSizeMake(self.collectionView.width, 60);
    }
    return CGSizeMake((kScreenWidth - kLeftSpace - (kRowNumbers + 1) * kSpaceWidth) / kRowNumbers, (kScreenWidth - kLeftSpace - (kRowNumbers + 1) * kSpaceWidth) / kRowNumbers / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(kSpaceWidth, kSpaceWidth, kSpaceWidth, kSpaceWidth);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.width, 40);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(self.collectionView.width, 5);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        THScreeningViewSectionHead *head = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"head" forIndexPath:indexPath];
        head.titleLabel.text = @[@"价格区间",@"全部分类",@"属性1",@"属性2",@"属性3"][indexPath.section];
        return head;
    }
    UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"foot" forIndexPath:indexPath];
    foot.backgroundColor = BGColor;
    return foot;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(kScreenWidth, 40, kScreenWidth-kLeftSpace, kScreenHeight-kNaviHeight-44-40) collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.allowsMultipleSelection = YES;
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(THSingleLabelCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THSingleLabelCell.class)];
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(THScreeningPriceCell.class) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THScreeningPriceCell.class)];
        [_collectionView registerClass:[THScreeningViewSectionHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"head"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"foot"];
    }
    return _collectionView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth - kSpaceWidth, 40)];
        _topView.backgroundColor = [UIColor whiteColor];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, _topView.width, _topView.height)];
        title.font = Font(15);
        title.textColor = GRAY_COLOR(81);
        title.text = @"筛选";
        [_topView addSubview:title];
    }
    return _topView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(kScreenWidth, kScreenHeight-kNaviHeight-44, kScreenWidth-kLeftSpace, 44)];
        _bottomView.backgroundColor = BGColor;
        for (NSInteger  i = 0; i < 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@[@"重置",@"确定"][i] forState:UIControlStateNormal];
            btn.titleLabel.font = Font(15);
            [btn addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = i?GLOBAL_RED_COLOR:[UIColor whiteColor];
            [btn setTitleColor:(i?[UIColor whiteColor]:GRAY_COLOR(100)) forState:UIControlStateNormal];
            btn.frame = CGRectMake(_bottomView.width*0.5*i, 1, _bottomView.width*0.5, 44);
            btn.tag = i;
            [_bottomView addSubview:btn];
        }
    }
    return _bottomView;
}

@end


@implementation THScreeningViewSectionHead

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(10);
            make.centerY.offset(0);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = GRAY_COLOR(81);
        _titleLabel.font = Font(15);
    }
    return _titleLabel;
}

@end

