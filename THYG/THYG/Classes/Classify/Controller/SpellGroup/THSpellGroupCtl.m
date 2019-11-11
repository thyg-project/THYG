//
//  THSpellGroupCtl.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupCtl.h"
#import "THYNPCSectionView.h"
#import "THPLTGCollectionViewCell.h"

@interface THSpellGroupCtl () {
    THYNPCSectionView *_headerView;
}

@end

@interface THSpellGroupCtl () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView * collectionView;


@end

@implementation THSpellGroupCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"批量团购";
    [self setNavigationBarColor:RGB(59, 59, 59)];
    _headerView = [THYNPCSectionView new];
    [self.view addSubview:_headerView];
    [self.view addSubview:self.collectionView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(38);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(_headerView.mas_bottom);
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THPLTGCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = kBackgroundColor;
        layout.itemSize = CGSizeMake((kScreenWidth - 24) / 2, WIDTH(175) + 88);
        layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        [_collectionView registerClass:[THPLTGCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}


@end

