//
//  THYNPCViewController.m
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THYNPCViewController.h"
#import "THYNPCSectionView.h"
#import "THYNPCTableViewCell.h"

@interface THYNPCViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation THYNPCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.controllerType == ViewControllerType_YNPC ? @"邀你品尝" : @"时令预售";
    [self setup];
}

- (void)setup {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self autoLayoutSizeContentView:_tableView];
    _tableView.tableHeaderView = [self headerView];
    [_tableView registerClass:[THYNPCTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THYNPCSectionView *sectionView = [[THYNPCSectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 38)];
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THYNPCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)headerView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.controllerType == ViewControllerType_YNPC ? 122 : 224)];
    UIImageView *imageView = [UIImageView new];
    imageView.backgroundColor = [UIColor redColor];
    [headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    return headerView;
}

@end
