//
//  THEverydayGoodsView.m
//  THYG
//
//  Created by C on 2019/10/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THEverydayGoodsView.h"


@interface THEveryGoodsCell : UICollectionViewCell {
    UIImageView *_imageView;
    UILabel *_nameLabel;
    
    UILabel *_pLabel;
}

@end

@implementation THEveryGoodsCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@16);
        make.size.mas_equalTo(CGSizeMake(145, 145));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:12];
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = UIColorHex(0x121212);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(4);
        make.left.right.equalTo(imageView);
    }];
    
    
    UILabel *time = [UILabel new];
    [self addSubview:time];
    time.textColor = UIColorHex(0xD62326);
    time.font = [UIFont systemFontOfSize:16];
    [time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(4);
    }];
    _pLabel = time;
    _imageView = imageView;
    _nameLabel = titleLabel;
}

- (void)setModel:(THFavouriteGoodsModel *)model {
    [_imageView setImageWithURL:[NSURL URLWithString:model.original_img] placeholder:[UIImage imageNamed:@""] options:YYWebImageOptionSetImageWithFadeAnimation completion:nil];
    _nameLabel.text = model.goods_name;
    _pLabel.text = [@"¥ " stringByAppendingString:model.shop_price];
}

@end


@interface THEverydayGoodsView() <UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *_collectionView;
}

@end

@implementation THEverydayGoodsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 16;
        [self setup];
    }
    return self;
}

- (void)setup {
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"每日精选";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = UIColorHex(0x121212);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.equalTo(@16);
        make.height.mas_equalTo(22);
    }];
    
    UILabel *desLabel = [UILabel new];
    desLabel.font = [UIFont systemFontOfSize:12];
    desLabel.textColor = UIColorHex(0x989898);
    desLabel.text = @"更多精选  >";
    [desLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(more)]];
    [self addSubview:desLabel];
    [desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.centerY.equalTo(titleLabel);
    }];
    UIView *line = [UIView new];
    
    line.backgroundColor = ColorWithHex(0x989898,.1);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(@38);
    }];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.dataSource = self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:_collectionView];
    layout.itemSize = CGSizeMake(floor((kScreenWidth - 32 - 4) / 2.0), 203);
    layout.headerReferenceSize = CGSizeZero;
    layout.footerReferenceSize = CGSizeZero;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(line.mas_bottom);
        make.left.equalTo(@2);
        make.right.equalTo(@(-2));
    }];
    [_collectionView registerClass:[THEveryGoodsCell class] forCellWithReuseIdentifier:@"goodsCell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THEveryGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"goodsCell" forIndexPath:indexPath];
    [cell setModel:_models[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.models.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(goodsView:didSelctedItem:)]) {
        [self.delegate goodsView:self didSelctedItem:_models[indexPath.item]];
    }
}

- (void)setModels:(NSArray<THFavouriteGoodsModel *> *)models {
    _models = models;
    [_collectionView reloadData];
}

- (void)more {
    if ([self.delegate respondsToSelector:@selector(moreGoods)]) {
        [self.delegate moreGoods];
    }
}

@end
