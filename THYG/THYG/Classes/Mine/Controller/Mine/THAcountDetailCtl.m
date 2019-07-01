//
//  THAcountDetailCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAcountDetailCtl.h"
#import "THAccountDetailCell.h"

@interface THAcountDetailCtl ()
@property (weak, nonatomic) IBOutlet UIView *headView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation THAcountDetailCtl

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.balanceCateType != recommandBalanceType) {
        self.headView.hidden = YES;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass(THAccountDetailCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THAccountDetailCell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THAccountDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THAccountDetailCell.class)];
    
    return cell;
}

@end
