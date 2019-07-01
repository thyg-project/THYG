
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


@interface THMyMessageCtl ()
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
    
    [self initFromNib];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@70);
    }];
    [self.tableView registerNib:[UINib nibWithNibName:@"THMyMessageListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
}

- (void)initFromNib
{
    [self.customServiceBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:3];
    [self.systemNotificationBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:3];
    [self.activityRecommendBtn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleTop imageTitleSpace:3];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THMyMessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
    return cell;
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
