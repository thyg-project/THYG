//
//  THWDDBViewController.m
//  THYG
//
//  Created by C on 2019/11/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THWDDBViewController.h"
#import "THWDDBTableViewCell.h"

@interface THWDDBViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSArray *_datas;
}
 
@end

@implementation THWDDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    
}
- (void)setup {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
     [self autoLayoutSizeContentView:_tableView];
    _tableView.dataSource = self;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    _tableView.estimatedRowHeight = 112;
   
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [_tableView registerClass:[THWDDBTableViewCell class] forCellReuseIdentifier:@"cell"];
    [_tableView registerClass:[THWDDB1TableViewCell class] forCellReuseIdentifier:@"cell1"];
    [_tableView registerClass:[THWDDB2TableViewCell class] forCellReuseIdentifier:@"cell2"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;//_datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 8)];
    view.backgroundColor = UIColor.clearColor;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 3 == 0) {
        THWDDBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        return cell;
    }
    if (indexPath.row % 3 == 1) {
        THWDDB1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1" forIndexPath:indexPath];
        return cell;
    }
    THWDDB2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
