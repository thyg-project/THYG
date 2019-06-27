
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

@end

@implementation THMyMessageCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的消息";
    
    [self initFromNib];
    
    [self.view addSubview:self.dataTableView];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@70);
    }];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"THMyMessageListCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMyMessageListCell.class)];
    
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
    [self pushVC:sysMsg];
}
- (IBAction)activityRecommandBtnClick:(id)sender {
    THActivityRecommandCtl *activity = [[THActivityRecommandCtl alloc] init];
    [self pushVC:activity];
}


@end
