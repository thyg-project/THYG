
//
//  THMyMessageCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMyMessageCtl.h"
#import "THMyMessageListCell.h"
#import "THActivityRecommandCtl.h"
#import "THSystemMessageCtl.h"


@interface THMyMessageCtl () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *customServiceBtn;
@property (weak, nonatomic) IBOutlet UIButton *systemNotificationBtn;
@property (weak, nonatomic) IBOutlet UIButton *activityRecommendBtn;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THMyMessageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的消息";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@70);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THMyMessageListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THMyMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (IBAction)customServiceBtnClick:(id)sender {
}

- (IBAction)systemNotificationBtnClick:(id)sender {
    THSystemMessageCtl *sysMsg = [[THSystemMessageCtl alloc] init];
    [self.navigationController pushViewController:sysMsg animated:YES];
}

- (IBAction)activityRecommandBtnClick:(id)sender {
    THActivityRecommandCtl *activity = [[THActivityRecommandCtl alloc] init];
    [self.navigationController pushViewController:activity animated:YES];
}


@end
