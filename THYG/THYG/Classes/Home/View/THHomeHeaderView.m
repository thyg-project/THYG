//
//  THHomeHeaderView.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeHeaderView.h"
#import <SDCycleScrollView/SDCycleScrollView.h>
#import "THHomeHeaderItemCell.h"

@interface THHomeHeaderView () <SDCycleScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource> {
	NSArray *_titles;
	NSMutableArray *_itemsArray;
}
@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong) UICollectionView * collectionView;
@end

static NSString * const THHomeHeaderItemCellId = @"THHomeHeaderItemCell";

@implementation THHomeHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self addSubview:self.cycleScrollView];
		[self addSubview:self.collectionView];
		_cycleScrollView.imageURLStringsGroup = @[@"banner"];
		_titles = @[@"新人专场",@"领特币",@"优惠券",@"会员注册",@"邀您品尝",@"时令预售",@"批量团购",@"地方特产"];
		_itemsArray = [NSMutableArray arrayWithCapacity:_titles.count];
		for (NSInteger i = 0; i < _titles.count; i++) {
			THHomeHeaderItemModel *model = [[THHomeHeaderItemModel alloc] init];
			model.name = _titles[i];
			[_itemsArray addObject:model];
		}
		
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	[self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.left.right.offset(0);
		make.height.offset(WIDTH(195));
	}];
	
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.right.offset(0);
		make.top.equalTo(self.cycleScrollView.mas_bottom);
        make.bottom.equalTo(self);
	}];
}

- (void)setImageUrls:(NSArray *)imageUrls {
	_imageUrls = imageUrls;
	self.cycleScrollView.imageURLStringsGroup = imageUrls;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return _titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	THHomeHeaderItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:THHomeHeaderItemCellId forIndexPath:indexPath];
	THHomeHeaderItemModel *model = _itemsArray[indexPath.item];
	cell.itemModel = model;
	return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	return UIEdgeInsetsMake(0, 5, 0, 5);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if (self.clickMenuItem) {
        self.clickMenuItem(indexPath.item,_itemsArray[indexPath.item]);
    }
}

- (SDCycleScrollView *)cycleScrollView {
	if (!_cycleScrollView) {
		_cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
	}
	return _cycleScrollView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionVertical;
		layout.minimumLineSpacing = 0;
		layout.minimumInteritemSpacing = 0;
		layout.itemSize = CGSizeMake((kScreenWidth - 10)/ 4, WIDTH(85));
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = kBackgroundColor;
		_collectionView.pagingEnabled = YES;
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"THHomeHeaderItemCell" bundle:nil] forCellWithReuseIdentifier:THHomeHeaderItemCellId];
	}
	return _collectionView;
}


@end
