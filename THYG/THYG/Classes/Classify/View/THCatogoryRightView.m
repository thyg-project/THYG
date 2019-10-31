//
//  THCatogoryRightView.m
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCatogoryRightView.h"
#import "THFilterView.h"

@interface THCategoryRightCell : UICollectionViewCell
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_priceLabel;
}

@end

@implementation THCategoryRightCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor yellowColor];
        [self setup];
    }
    return self;
}

- (void)setup {
    _imageView = [UIImageView new];
    _imageView.backgroundColor = [UIColor redColor];
    [self addSubview:_imageView];
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:12];
    _titleLabel.textColor = UIColorHex(0x717171);
    _titleLabel.numberOfLines = 2;
    _titleLabel.text= @"ceshi";
    [self addSubview:_titleLabel];
    _priceLabel = [UILabel new];
    _priceLabel.textColor = UIColorHex(0xE11321);
    _priceLabel.font = [UIFont systemFontOfSize:16];
    _priceLabel.text = @"¥168";
    [self addSubview:_priceLabel];
    
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(_titleLabel.mas_top);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(_priceLabel.mas_top);
        make.height.mas_equalTo(36);
    }];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(17);
        make.bottom.equalTo(@(-16));
    }];
}

@end


@interface THCatogoryRightView() <UICollectionViewDelegate, UICollectionViewDataSource, THFilterViewDelegate> {
    UICollectionView *_collectionView;
    UILabel *_titleLabel;
    UITextField *_textFiled;
    THFilterView *_filterView;
}

@end

@implementation THCatogoryRightView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorHex(0xf7f8f9);
        [self setup];
    }
    return self;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setup {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    [self addSubview:_collectionView];
    CGFloat width = floor((kScreenWidth - 96 - WIDTH(35) - 64) / 2.0);
    layout.itemSize = CGSizeMake(width, width + 76);
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(8, 32, 0, 32);
    [_collectionView registerClass:[THCategoryRightCell class] forCellWithReuseIdentifier:@"rightCell"];
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:20];
    _textFiled.textColor = UIColorHex(0x717171);
    [self addSubview:_titleLabel];
    _textFiled = [[UITextField alloc] init];
    [self addSubview:_textFiled];
    
    _filterView = [[THFilterView alloc] initWithDatas:@[@"综合",@"销量",@"筛选"] horizontalSpace:0];
    _filterView.font = [UIFont systemFontOfSize:16];
    _filterView.normalColor = UIColorHex(0x989898);
    _filterView.backgroundColor = UIColorHex(0xf7f8f9);
    _filterView.delegate = self;
    [self addSubview:_filterView];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.height.mas_equalTo(28);
        make.left.equalTo(@32);
    }];
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).offset(8);
        make.left.equalTo(_titleLabel);
        make.right.equalTo(@(-32));
        make.height.mas_equalTo(32);
    }];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(38);
        make.left.right.equalTo(self);
        make.top.equalTo(_textFiled.mas_bottom);
    }];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(_filterView.mas_bottom);
    }];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THCategoryRightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rightCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;//self.modes.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(categoryView:itemDidSelctedIndexPath:)]) {
        [self.delegate categoryView:self itemDidSelctedIndexPath:indexPath];
    }
}

- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
    
}


@end
