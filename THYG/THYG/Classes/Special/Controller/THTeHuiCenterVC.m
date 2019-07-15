//
//  THTeHuiCenterVC.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCenterVC.h"
#import "THTeHuiCell.h"
#import "THTeHuiModel.h"
#import "THMenuView.h"

@interface THTeHuiCenterVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UIButton *titleBtnView;
@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) THMenuView *menuView;


@end

@implementation THTeHuiCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self setMunes];
    
    [self getMyCommentList:@"1"];
    
}

- (void)setMunes {
    _menuView = [THMenuView new];
    self.menuView.data = @[@"晒单",@"特"];
    kWeakSelf
    self.menuView.selectedAction = ^(NSInteger index) {
        weakSelf.titleBtnView.selected = NO;
        
    };
    [self.view addSubview:self.menuView];
}

- (void)setupUI {
    self.navigationItem.leftBarButtonItem = self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.titleView = self.titleBtnView;
    [self.view addSubview:self.topView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[THTeHuiCell class] forCellReuseIdentifier:NSStringFromClass(THTeHuiCell.class)];
}

#pragma mark - 获取晒单列表
- (void)getMyCommentList:(NSString *)type {

}


#pragma mark - UITableView 代理 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    THTeHuiCell * cell = nil;
    [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THTeHuiCell.class)];
    cell.teModel = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 320;
}

#pragma mark - 按钮点击事件
- (void)btnClick {
    [self.menuView show];
    self.titleBtnView.selected = YES;
}

- (void)topViewClick:(UIButton *)sender {
    NSInteger tag = sender.tag - kScreenWidth;
    NSLog(@"tag %ld", tag);
    [self getMyCommentList:[NSString stringWithFormat:@"%ld", tag+1]];
}

#pragma mark - titleBtnView
- (UIButton*)titleBtnView {
    if (!_titleBtnView) {
        _titleBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtnView.frame = CGRectMake(0, 0, 100, 40);
        [_titleBtnView setTitle:@"晒单" forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        _titleBtnView.titleLabel.font = Font(15);
        
        [_titleBtnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtnView;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        _topView.backgroundColor = BGColor;
        NSArray *titles = @[@"综合",@"评论数",@"好评率"];
        CGFloat bW = (kScreenWidth - 2) / 3;
        CGFloat bX = 0;
        for (NSInteger i = 0; i < titles.count; i++) {
            UIButton *btn = [[UIButton alloc] init];
            
            btn.tag = i + kScreenWidth;
//            btn.titleLabel.font = [UIFont systemFontOfSize:14];
            btn.backgroundColor = [UIColor whiteColor];
            [btn setTitleColor:GRAY_51 forState:UIControlStateNormal];
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            bX = i > 0 ? (bW + 1) * i  : 0;
            btn.frame = CGRectMake(bX, 0, bW, 44);
            [btn addTarget:self action:@selector(topViewClick:) forControlEvents:UIControlEventTouchUpInside];
            [_topView addSubview:btn];
        }
        
    }
    return _topView;
}

@end
