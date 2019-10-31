//
//  THHomeMallActivityCell.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeMallActivityCell.h"
#import "THHomeMallActivityItemCell.h"

@interface THHomeMallActivityCell () <UICollectionViewDelegate, UICollectionViewDataSource> {
	NSArray <THHomeActivityModel *>*_itemArray;
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) UILabel * titleLabel;
@end

static NSString * const THHomeMallActivityItemCellId = @"THHomeMallActivityItemCellId";

@implementation THHomeMallActivityCell

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorHex(0xf7f8f9);
		[self addSubview:self.titleLabel];
		[self addSubview:self.collectionView];
	}
	return self;
}

- (void)layoutSubviews {
	[super layoutSubviews];
	[self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.offset(8);
        make.left.equalTo(@8);
        make.right.equalTo(@(-8));
		make.height.offset(WIDTH(44));
	}];
	[self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
		make.bottom.offset(0);
        make.left.equalTo(@(8));
        make.right.equalTo(@(-8));
	}];
    [self.collectionView setCornerRadius:18 inCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight];
    [self.titleLabel setCornerRadius:18 inCorners:UIRectCornerTopRight | UIRectCornerTopLeft];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	THHomeMallActivityItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:THHomeMallActivityItemCellId forIndexPath:indexPath];
    cell.activityModel = _itemArray[indexPath.item];
	return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BLOCK(self.selectItemBlock,indexPath.item);
}


- (UILabel *)titleLabel {
	if (!_titleLabel) {
		_titleLabel = [THUIFactory labelWithText:@"商城活动" fontSize:24 tintColor:UIColorHex(0xD62326)];
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.backgroundColor = UIColorHex(0xffffff);
	}
	return _titleLabel;
}

- (UICollectionView *)collectionView {
	if (!_collectionView) {
		UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
		layout.scrollDirection = UICollectionViewScrollDirectionVertical;
		layout.minimumLineSpacing = 1;
		layout.minimumInteritemSpacing = 1;
		layout.itemSize = CGSizeMake((kScreenWidth-16)*0.5, WIDTH(108));
        layout.sectionInset = UIEdgeInsetsMake(8, 0, 0, 0);
		_collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
		_collectionView.delegate = self;
		_collectionView.dataSource = self;
		_collectionView.scrollEnabled = NO;
//        _collectionView.layer.masksToBounds = YES;
//        _collectionView.layer.cornerRadius = 8;
		_collectionView.showsHorizontalScrollIndicator = NO;
		_collectionView.backgroundColor = UIColorHex(0xffffff);
        _collectionView.backgroundView.backgroundColor = UIColorHex(0xffffff);
		[_collectionView registerClass:[THHomeMallActivityItemCell class] forCellWithReuseIdentifier:THHomeMallActivityItemCellId];
	}
	return _collectionView;
}

@end
