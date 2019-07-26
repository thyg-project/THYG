//
//  THSpellGroupHead.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupHead.h"
#import "THSpellGroupHeadCell.h"

@interface THSpellGroupHead()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *data;
@end

@implementation THSpellGroupHead

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    THSpellGroupHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THSpellGroupHeadCell.class) forIndexPath:indexPath];
    [cell refreshWithModel:self.data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (THSpellModel *m in self.data) {
        m.validate = NO;
    }
    THSpellModel *model = self.data[indexPath.row];
    model.validate = YES;
    [collectionView reloadData];
}

- (NSArray *)data {
    if (!_data) {
        NSMutableArray *tep = [NSMutableArray new];
        [tep addObject:[[THSpellModel alloc] initWithTime:@"18:00" state:@"团购中" validate:YES]];
        [tep addObject:[[THSpellModel alloc] initWithTime:@"19:00" state:@"即将开始" validate:NO]];
        [tep addObject:[[THSpellModel alloc] initWithTime:@"20:00" state:@"即将开始" validate:NO]];
        [tep addObject:[[THSpellModel alloc] initWithTime:@"21:00" state:@"即将开始" validate:NO]];
        [tep addObject:[[THSpellModel alloc] initWithTime:@"22:00" state:@"即将开始" validate:NO]];
        _data = tep.copy;
    }
    return _data;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kScreenWidth-self.data.count-1)/5, 50);
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 1, 1);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = kBackgroundColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"THSpellGroupHeadCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THSpellGroupHeadCell.class)];
    }
    return _collectionView;
}

@end
