//
//  THMyTaskCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyTaskCtl.h"
#import "THMyTaskCell.h"

@interface THMyTaskCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *mTable;
@property (nonatomic, strong) NSMutableArray *data;
@end

@implementation THMyTaskCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"任务中心";
    [self.view addSubview:self.mTable];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMyTaskCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMyTaskCell.class)];
    [cell refreshWithIndexPath:indexPath];
    return cell;
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kNaviHeight) style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = kBackgroundColor;
        _mTable.tableFooterView = [UIView new];
        _mTable.allowsSelection = NO;
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THMyTaskCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMyTaskCell.class)];
    }
    return _mTable;
}


@end
