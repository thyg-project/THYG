//
//  THUseCouponCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/5.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUseCouponCtl.h"
#import "THCouponsCell.h"
#import "THCartDetailModel.h"

@interface THUseCouponCtl () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THUseCouponCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择优惠券";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THCouponsCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THCouponsCell.class)];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THCouponsCell.class)];
    cell.modelData = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectCouponBlock) {
        self.selectCouponBlock(self.dataSource[indexPath.row]);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
