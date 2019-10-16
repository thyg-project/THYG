//
//  THCommentVC.m
//  THYG
//
//  Created by Mac on 2018/4/7.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCommentVC.h"
#import "THGoodsCommentModel.h"
#import "THGoodsCommentCell.h"
#import "THCommentHead.h"
#import "THGoodsInfoPresenter.h"

@interface THCommentVC () <UITableViewDelegate, UITableViewDataSource, UITableViewDelegate, THGoodsInfoProtocol>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *commentArray;
@property (nonatomic, strong) THGoodsInfoPresenter *presenter;
@end

@implementation THCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _presenter = [[THGoodsInfoPresenter alloc] initPresenterWithProtocol:self];
    [THHUDProgress show];
    [self.presenter getComments:self.goods_id];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THCommentHead *head = [[THCommentHead alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    
    return head;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.commentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THGoodsCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THGoodsCommentCell.class)];
    cell.commentModel = self.commentArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:THGoodsCommentCell.class forCellReuseIdentifier:NSStringFromClass(THGoodsCommentCell.class)];
        
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    return _tableView;
}

- (void)getGoodsCommentsSuccess:(NSArray<THGoodsCommentModel *> *)list {
    
}

- (void)getGoodsCommentsFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}


@end
