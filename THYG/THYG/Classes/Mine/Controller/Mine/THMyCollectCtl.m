
//
//  THMyCollectCtl.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyCollectCtl.h"
#import "THMyCollectCell.h"
#import "THMyCollectModel.h"

@interface THMyCollectCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation THMyCollectCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.type? @"浏览记录" :@"我的关注";
    [self.view addSubview:self.mTable];
    [self autoLayoutSizeContentView:self.mTable];
    [self.mTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMyCollectCell.class)];
    THMyCollectModel *model = self.data[indexPath.row];
    cell.modelData = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THMyCollectCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMyCollectCell.class)];
    }
    return _mTable;
}

- (NSMutableArray*)data {
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

@end
