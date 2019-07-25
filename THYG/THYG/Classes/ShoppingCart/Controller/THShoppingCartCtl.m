//
//  THShoppingCartCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShoppingCartCtl.h"
#import "THShoppingCartListDelegate.h"
#import "THShoppingCartModel.h"
#import "THOrderConfirmCtl.h"
#import "THShareView.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "THCardSettleView.h"

@interface THShoppingCartCtl () <DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, THCardSettleDelegate> {
    THCardSettleView *_settleView;
}
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) UIButton *navBtn; // 导航按钮
@property (nonatomic,strong) THShoppingCartListDelegate *tableDelegate;

@end

@implementation THShoppingCartCtl

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableDelegate.dataArray removeAllObjects];
}

#pragma mark - 设置视图
- (void)setupUI {
    _settleView = [THCardSettleView new];
    _settleView.operaType = THCardOperaType_Settle;
    _settleView.delegate = self;
    [self.view addSubview:_settleView];
    [_settleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    [self.view addSubview:self.mTable];
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_settleView.mas_top);
    }];
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.navBtn];
}

#pragma mark - 编辑操作
- (void)editClick {
    if (_settleView.operaType == THCardOperaType_Settle) {
        _settleView.operaType = THCardOperaType_Editing;
         [_navBtn setTitle:@"完成" forState:UIControlStateNormal];
    } else {
        _settleView.operaType = THCardOperaType_Settle;
         [_navBtn setTitle:@"编辑" forState:UIControlStateNormal];
    }
}

#pragma mark - 购物车操作
/**
 购物车操作
 @param carId 选中商品购物车id数组
 @param delete YES 为delete 商品， NO为移入收藏
 */
- (void)carActionWithCarIds:(NSString *)carId isDelete:(BOOL)delete {
    NSString *message = delete ? @"确定要删除所选产品吗?" : @"确定要关注所选商品吗？关注成功后，将从购物车删除，请您确认";
    NSString *title = delete ? @"删除所选产品" : @"关注所选商品";
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (delete) {
        } else {
            [self removeGoodsFromCar:carId];
        }
        
    }];
    
    [sure setValue:[UIColor redColor] forKey:@"_titleTextColor"];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    [alertController addAction:sure];
    [alertController addAction:cancle];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

#pragma mark - 商品移入我的关注
- (void)removeGoodsFromCar:(NSString *)cart_ids {
    
    NSString *goods_ids = @"[";
    for (THCartGoodsModel *model in self.tableDelegate.dataArray) {
        goods_ids = [[goods_ids stringByAppendingString:model.goods_id] stringByAppendingString:@","];
    }
    goods_ids = [[goods_ids substringToIndex:goods_ids.length-1] stringByAppendingString:@"]"];
    
    
}

#pragma mark - 空数据
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"noOrder"];
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"暂无商品，快去逛逛吧~" attributes:@{NSForegroundColorAttributeName:RGB(151, 151, 151), NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    return string;
}

#pragma mark --
- (void)share:(THCardSettleView *)settleView {
    
}

- (void)settle:(THCardSettleView *)settleView {
    
}

- (void)selectedAll:(THCardSettleView *)settleView selected:(BOOL)selected {
    if (selected) {
         [_settleView updateContentText:@"合计：¥0.00"];
    } else {
         [_settleView updateContentText:nil];
    }
   
}

- (void)move:(THCardSettleView *)settleView {
    
}

- (void)deleteGoods:(THCardSettleView *)settleView {
    
}

#pragma mark - 懒加载
- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mTable.backgroundColor = kBackgroundColor;
        _mTable.tableFooterView = [UIView new];
        [self.tableDelegate registerTable:_mTable];
        _mTable.delegate = self.tableDelegate;
        _mTable.dataSource = self.tableDelegate;
        _mTable.emptyDataSetSource = self;
        _mTable.emptyDataSetDelegate = self;
    }
    return _mTable;
}

- (THShoppingCartListDelegate *)tableDelegate {
    if (!_tableDelegate) {
        _tableDelegate = [[THShoppingCartListDelegate alloc] init];
    }
    return _tableDelegate;
}

- (UIButton *)navBtn {
    if (!_navBtn) {
        _navBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _navBtn.frame = CGRectMake(0, 0, 30, 30);
        [_navBtn setTitle:@"管理" forState:UIControlStateNormal];
        _navBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_navBtn addTarget:self action:@selector(editClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _navBtn;
}

@end
