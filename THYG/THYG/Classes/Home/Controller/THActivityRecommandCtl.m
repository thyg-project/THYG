//
//  THActivityRecommandCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THActivityRecommandCtl.h"
#import "THSingImgCell.h"

@interface THActivityRecommandCtl ()

@end

@implementation THActivityRecommandCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"活动消息";
    [self.view addSubview:self.dataTableView];
    [self.dataTableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view);
     }];
    [self.dataTableView registerNib:[UINib nibWithNibName:@"THSingImgCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THSingImgCell.class)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    THSingImgCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THSingImgCell.class)];
    
    return cell;
}

@end
