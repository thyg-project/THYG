//
//  THMyToolsPage.m
//  THYG
//
//  Created by C on 2019/10/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THMyToolsPage.h"


@interface THToolsCell : UICollectionViewCell {
    UIImageView *_imageView;
    UILabel *_titleLabel;
}

@end

@implementation THToolsCell

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
        make.top.equalTo(@18);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:12];
    titleLabel.textColor = UIColorHex(0x121212);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(4);
        make.centerX.equalTo(imageView);
    }];
    _imageView = imageView;
    _titleLabel = titleLabel;
}

- (void)setContent:(NSString *)content {
    _titleLabel.text = content;
    _imageView.image = [UIImage imageNamed:[content stringByAppendingString:@".png"]];
}

@end



@interface THMyToolsPage() <UICollectionViewDataSource, UICollectionViewDelegate> {
    UICollectionView *_collectionView;
    NSArray <NSString *> *_titles;
}

@end

@implementation THMyToolsPage

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
    _titles = @[@"商品分类",@"推广二维码",@"供应专员",@"供应商",@"团队管理",@"我的关注",@"我的晒单",@"浏览记录",@"我的钱包",@"账户设置"];
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"必备工具";
    titleLabel.font = [UIFont boldSystemFontOfSize:16];
    titleLabel.textColor = UIColorHex(0x121212);
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.equalTo(@16);
        make.height.mas_equalTo(22);
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
    [self addSubview:_collectionView];
    layout.itemSize = CGSizeMake(floor((kScreenWidth - 32- 4) / 5.0), 75);
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
    [_collectionView registerClass:[THToolsCell class] forCellWithReuseIdentifier:@"toolsCell"];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THToolsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"toolsCell" forIndexPath:indexPath];
    [cell setContent:_titles[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titles.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(toolPage:didSelectedIndexPath:content:)]) {
        [self.delegate toolPage:self didSelectedIndexPath:indexPath content:_titles[indexPath.item]];
    }
}


@end
