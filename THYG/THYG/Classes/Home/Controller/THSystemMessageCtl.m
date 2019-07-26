//
//  THSystemMessageCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSystemMessageCtl.h"
#import "THSystemMessageCell.h"
#import "THMessagePresenter.h"

@interface THSystemMessageCtl () <UITableViewDataSource, UITableViewDelegate, THMessageProtocol> {
    NSMutableArray <THMessageModel *> *_dataSource;
}

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) THMessagePresenter *presenter;

@end

@implementation THSystemMessageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"系统消息";
    _presenter = [[THMessagePresenter alloc] initPresenterWithProtocol:self];
    [_presenter loadSystemMessage];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THSystemMessageCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THSystemMessageCell.class)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THSystemMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THSystemMessageCell.class)];
    
    return cell;
}

#pragma mark --
- (void)loadMessageSuccess:(NSArray<THMessageModel *> *)response {
    _dataSource = response.mutableCopy;
}

- (void)loadMessageFailed:(NSDictionary *)errorInfo {
    
}
@end
