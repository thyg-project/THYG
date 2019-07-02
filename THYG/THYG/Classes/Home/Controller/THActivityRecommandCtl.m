//
//  THActivityRecommandCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THActivityRecommandCtl.h"
#import "THSingImgCell.h"

@interface THActivityRecommandCtl () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THActivityRecommandCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"活动消息";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view);
     }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THSingImgCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THSingImgCell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THSingImgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THSingImgCell.class)];
    
    return cell;
}

@end
