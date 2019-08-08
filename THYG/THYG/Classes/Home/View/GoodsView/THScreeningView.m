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
@property (nonatomic, strong) UIView *containerView;

@end

@implementation THScreeningView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.containerView];
        [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(kLeftSpace));
            make.right.top.bottom.equalTo(self);
        }];
        [self.containerView addSubview:self.collectionView];
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
        title.font = Font(15);
        title.textColor = RGB(81,81,81);
        title.text = @"筛选";
        [self.containerView addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@10);
            make.right.top.equalTo(self.containerView);
            make.height.mas_equalTo(40);
        }];
        
        [self addTarget:self action:@selector(dismissMasView) forControlEvents:UIControlEventTouchUpInside];
        for (NSInteger  i = 0; i < 2; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:@[@"重置",@"确定"][i] forState:UIControlStateNormal];
            btn.titleLabel.font = Font(15);
            [btn addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            btn.backgroundColor = i?RGB(213, 0, 27):[UIColor whiteColor];
            [btn setTitleColor:(i?[UIColor whiteColor]:RGB(100,100,100)) forState:UIControlStateNormal];
            btn.tag = i;
            [self.containerView addSubview:btn];
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self.containerView);
                make.height.mas_equalTo(44);
                make.width.equalTo(@((kScreenWidth - kLeftSpace) / 2));
                make.left.mas_equalTo((kScreenWidth - kLeftSpace) / 2 * i);
            }];
        }
        UIView *line = [UIView new];
        line.backgroundColor = kBackgroundColor;
        [self.containerView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.height.mas_equalTo(1);
            make.bottom.equalTo(self.containerView).offset(-44);
        }];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.containerView);
            make.top.equalTo(title.mas_bottom);
            make.bottom.equalTo(line.mas_top);
        }];
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
            if ([self.delegate respondsToSelector:@selector(screenResultContainer:catId:startProce:endPrice:)]) {
                [self.delegate screenResultContainer:self catId:_catId startProce:_startPrice endPrice:_endPrice];
            }
            [self dismissMasView];
        }
            break;
        default:
            break;
    }
}

- (void)showInView:(UIView *)inView {
    if (!inView) {
        inView = [UIApplication sharedApplication].delegate.window;
    }
    [inView addSubview:self];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
    }];
    [UIView animateWithDuration:.2 animations:^{
        [self.superview layoutIfNeeded];
    }];
}

- (void)dismissMasView {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kScreenWidth));
    }];
    [UIView animateWithDuration:.2 animations:^{
        [self.superview layoutIfNeeded];
    }];
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
    if (section == 0) {
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
    cell.contentView.backgroundColor = RGB(213, 213, 213);
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
    foot.backgroundColor = kBackgroundColor;
    return foot;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[UICollectionViewFlowLayout alloc] init]];
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
        _titleLabel.textColor = RGB(81,81,18);
        _titleLabel.font = Font(15);
    }
    return _titleLabel;
}

@end

