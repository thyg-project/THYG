//
//  THHomeShowMenuView.m
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMenuView.h"

@interface THMenuView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mTable;

@end

@implementation THMenuView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.mTable];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.mTable.frame = CGRectMake(0, 0, kScreenWidth, 0);
        self.frame = CGRectMake(0, 0, kScreenWidth, 0);
        [self addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setData:(NSArray *)data {
    _data = data;
    [self.mTable reloadData];
}

- (void)show {
    if (!YGInfo.validArray(self.data)) {
        NSLog(@"缺少数据");
        return;
    }
    self.height = kScreenHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.mTable.height = 44*self.data.count-1;
    }];
}

- (void)hidden {
    [UIView animateWithDuration:0.3 animations:^{
        self.mTable.height = 0;
    } completion:^(BOOL finished) {
        self.height = 0;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = Font(15);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hidden];
    if (self.selectedAction) {
        self.selectedAction(indexPath.row);
    }
}


- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _mTable;
}

@end
