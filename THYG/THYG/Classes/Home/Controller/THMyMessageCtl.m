
//
//  THMyMessageCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyMessageCtl.h"
#import "THMyMessageListCell.h"
#import "THActivityRecommandCtl.h"
#import "THSystemMessageCtl.h"
#import "THFilterView.h"


@interface THMyMessageCtl () <UITableViewDataSource, UITableViewDelegate, THFilterViewDelegate> {
    THFilterView *_filterView;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THMyMessageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的消息";
    _filterView = [[THFilterView alloc] initWithDatas:@[@"客服",@"服务通知",@"活动推荐"] horizontalSpace:0];
    _filterView.delegate = self;
    _filterView.font = [UIFont systemFontOfSize:14];
    _filterView.imageNames = @[@"tetubiao",@"tetubiao",@"tetubiao"];
    _filterView.imageMargenToText = 5;
    [self.view addSubview:_filterView];
    [_filterView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(70);
    }];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_filterView.mas_bottom);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THMyMessageListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMyMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)filterView:(THFilterView *)filterView disSelectedItem:(NSString *)item selectedIndex:(NSInteger)index {
   
    if (index == 1) {
        [self.navigationController pushViewController:[THSystemMessageCtl new] animated:YES];
    } else if (index == 2) {
        [self.navigationController pushViewController:[THActivityRecommandCtl new] animated:YES];
    }
}


@end
