//
//  THTBDBViewController.m
//  THYG
//
//  Created by C on 2019/11/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTBDBViewController.h"
#import "THTBDBSectionHeader.h"
#import "THZXDBTableViewCell.h"
#import "THSectionView.h"

@interface THTBDBViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_datas;
}
@end

@implementation THTBDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"特币夺宝";
    [self setup];
}

- (void)setup {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [self headerView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_tableView registerClass:[THQBDBTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[THZXDBTableViewCell class] forCellReuseIdentifier:@"zxCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;//_datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 32;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    THSectionFooter *footer = [[THSectionFooter alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 32)];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THTBDBSectionHeader *header = [[THTBDBSectionHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    header.title = [@[@"最新揭晓",@"全部夺宝"] objectAtIndex:section];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        THZXDBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"zxCell" forIndexPath:indexPath];
        return cell;
    } else {
        THQBDBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)headerView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 180)];
    UIImageView *imageView = [UIImageView new];
    [headerView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView);
    }];
    return headerView;
}





@end
