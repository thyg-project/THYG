//
//  THSpellGroupHead.m
//  THYG
//
//  Created by Colin on 2018/3/21.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSpellGroupHead.h"
#import "THSpellGroupHeadCell.h"

static NSString *const kTimeKey = @"time";
static NSString *const kStatusKey = @"status";
static NSString *const kImageValidateKey = @"is_ing";

@interface THSpellGroupHead()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *data;
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
    [cell refreshWithDic:self.data[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    for (NSMutableDictionary *dic in self.data) {
        dic[kImageValidateKey] = @"0";
    }
    NSMutableDictionary *dic = self.data[indexPath.row];
    dic[kImageValidateKey] = @"1";
    [collectionView reloadData];
}

- (NSMutableArray *)data {
    if (!_data) {
        _data = @[@{kTimeKey:@"18:00",kStatusKey:@"团购中",kImageValidateKey:@"1"}.mutableCopy,@{kTimeKey:@"19:00",kStatusKey:@"即将开始",kImageValidateKey:@"0"}.mutableCopy,@{kTimeKey:@"20:00",kStatusKey:@"即将开始",kImageValidateKey:@"0"}.mutableCopy,@{kTimeKey:@"21:00",kStatusKey:@"即将开始",kImageValidateKey:@"0"}.mutableCopy,@{kTimeKey:@"22:00",kStatusKey:@"即将开始",kImageValidateKey:@"0"}.mutableCopy].mutableCopy;;
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
        _collectionView.backgroundColor = BGColor;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"THSpellGroupHeadCell" bundle:nil] forCellWithReuseIdentifier:NSStringFromClass(THSpellGroupHeadCell.class)];
    }
    return _collectionView;
}

@end
