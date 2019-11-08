//
//  THCouponCenterViewController.m
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCouponCenterViewController.h"
#import "THCouponCenterTableViewCell.h"

@interface THCouponCenterViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
}

@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation THCouponCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"领券中心";
    [self setup];
}

- (void)setup {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 17)];
    label.text = @"我的券";
    label.textColor = UIColorHex(0xff3c00);
    label.font = [UIFont systemFontOfSize:12];
    [label addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mineCoupon)];
        tap;
    })];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:label];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self autoLayoutSizeContentView:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.right.equalTo(@(-8));
        make.top.bottom.equalTo(self.view);
    }];
    [_tableView registerClass:[THCouponCenterTableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

- (void)mineCoupon {
    
}













- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 112;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCouponCenterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.couponModel = nil;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
