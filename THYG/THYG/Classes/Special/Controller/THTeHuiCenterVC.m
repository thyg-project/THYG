//
//  THTeHuiCenterVC.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCenterVC.h"
#import "EWaterFallView.h"
#import "THTeHuiModel.h"
#import "THTeCenterPresenter.h"
#import "THTeCtl.h"
#import "THTeListCollectionViewCell.h"


@interface THTeHuiCenterVC () <THTeCenterProtocol> {
    
}
@property (nonatomic, strong) EWaterFallView *collectionView;
@property (nonatomic, strong) NSMutableArray <THTeHuiModel *>*dataSource;
@property (nonatomic, strong) THTeCenterPresenter *presenter;

@end

@implementation THTeHuiCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"特广场";
    _presenter = [[THTeCenterPresenter alloc] initPresenterWithProtocol:self];
    [_presenter getTeData:1];
    [self setupUI];
}

- (void)setupUI {
    _collectionView = [[EWaterFallView alloc] init];
    _collectionView.registerClassCell = NSStringFromClass(THTeListCollectionViewCell.class);
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    kWeakSelf;
    [_collectionView setSetParamBlock:^(EWaterFallLayout *layout) {
        layout.columnCount = 2;
        layout.sectionInset = UIEdgeInsetsZero;
        layout.rowSpacing = 8;
        layout.columnSpacing = 8;
    }];
    [_collectionView setItemHeightBlock:^CGFloat(CGFloat itemWidth, NSIndexPath *indexPath) {
        kStrongSelf;
        return 100;
//        return strongSelf.dataSource[indexPath.row].;
    }];
    [_collectionView setNumberOfRowsBlock:^NSInteger{
        kStrongSelf;
        return strongSelf.dataSource.count;
    }];
    [_collectionView setCellDataBlock:^id(UICollectionViewCell *cell, NSIndexPath *indexPath) {
        kStrongSelf;
        return strongSelf.dataSource[indexPath.row];
    }];
    [_collectionView setDidSelectAtIndexPathBlock:^(NSIndexPath *indexPath) {
        
    }];
    [_collectionView reloadData];
}



#pragma mark --Protocol
- (void)loadTeSuccess:(NSArray<THTeHuiModel *> *)response {
    _dataSource = response.mutableCopy;
}

- (void)loadTeFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

@end
