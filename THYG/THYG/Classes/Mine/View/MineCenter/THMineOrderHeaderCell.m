//
//  THMineOrderHeaderCell.m
//  THYG
//
//  Created by Victory on 2018/3/16.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineOrderHeaderCell.h"
#import "THButton.h"
#define bX kScreenWidth / 5

@interface THMineOrderHeaderCell ()/* <UICollectionViewDelegate, UICollectionViewDataSource> */{
	NSArray * _imageArr;
	NSArray * _titleArr;
    
//    UICollectionView *_collectionView;
    
}

@end

@implementation THMineOrderHeaderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		[self setupUI];
	}
	return self;
}

//- (void)initinalizedView {
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    _collectionView.delegate = self;
//    _collectionView.dataSource = self;
//    [self addSubview:_collectionView];
//    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//}

- (void)setupUI {
	_imageArr = @[@"daifukuan", @"daishouhuo", @"daipingjia", @"tuihuanhuo", @"quanbudingdan"];
	_titleArr = @[@"待付款", @"待收货", @"待评价", @"退/换货", @"全部订单"];
	for (NSInteger i = 0; i <5; i++) {
		THButton *button = [[THButton alloc] initWithButtonType:THButtonType_imageTop];
		button.tag = i + bX;
        button.title = _titleArr[i];
        button.textColor = GRAY_COLOR(51);
        button.image = [UIImage imageNamed:_imageArr[i]];
		
		button.font = [UIFont systemFontOfSize:13];
        [button addTarget:self action:@selector(buttonAction:)];
		button.frame = CGRectMake(bX * i, 0, bX, 65);
		[self.contentView addSubview:button];
	}
}

- (void)buttonAction:(THButton *)button {
	!self.orderAction?:self.orderAction(button.tag - bX);
}

@end
