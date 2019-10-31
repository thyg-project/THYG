//
//  THClassifyVC.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THClassifyVC.h"
#import "THHomeHeaderItemCell.h"
#import "THClassifyHeaderView.h"
#import "THClassifyItemCell.h"
#import "THSearchView.h"
#import "THSpellGroupCtl.h"
#import "THLimitSpellGroupCtl.h"
#import "THFlashCtl.h"
#import "THScreeningGoodsCtl.h"
#import "THCategoryPresenter.h"
#import "THCategoryLeftView.h"
#import "THCatogoryRightView.h"

@interface THClassifyVC () <THCategoryProtocol, THCategoryRightViewDelegate, THCategoryLeftViewDelegate> {
	NSArray <NSArray <THCatogoryModel *>*>*_itemsArray;
    THCategoryLeftView *_leftView;
    THCatogoryRightView *_rightView;
}

@property (nonatomic, strong) THSearchView *searchView;
@property (nonatomic, strong) THCategoryPresenter *presenter;

@end

@implementation THClassifyVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分类";
    _presenter = [[THCategoryPresenter alloc] initPresenterWithProtocol:self];
    _leftView = [[THCategoryLeftView alloc] init];
    _leftView.delegate = self;
    _leftView.titles = @[@"优选水果",@"素材瓜果",@"肉类食品",@"海鲜水产",@"粮油食品",@"美食小吃",@"养生滋补",@"名酒名菜"];
    [self.view addSubview:_leftView];
    [_leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.equalTo(self.view);
        make.width.mas_equalTo(96);
    }];
    _rightView = [THCatogoryRightView new];
    _rightView.delegate = self;
    _rightView.title = _leftView.titles.firstObject;
    [self.view addSubview:_rightView];
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self.view);
        make.left.equalTo(_leftView.mas_right);
    }];
}

#pragma mark---
- (void)loadLocalizedSuccess:(NSArray<NSArray<THCatogoryModel *> *> *)data {
    _itemsArray = data;
    
}

- (void)searchSuccess:(id)result {
    self.searchView.searchResult = result;
}

- (void)searchFailed:(id)errorInfo {
    
}

- (void)loadCatogoryFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)loadCatogorySuccess:(NSArray<THCatogoryModel *> *)response {
    NSMutableArray *list = _itemsArray.mutableCopy;
    [list replaceObjectAtIndex:1 withObject:response];
    _itemsArray = list.copy;
    [THHUDProgress dismiss];
    
}

- (void)categoryLeftView:(THCategoryLeftView *)leftView didSelectedIndex:(NSIndexPath *)indexPath {
    _rightView.title = leftView.titles[indexPath.item];
}

- (void)categoryView:(THCatogoryRightView *)categoryView itemDidSelctedIndexPath:(NSIndexPath *)indexPath {
    
}
@end
