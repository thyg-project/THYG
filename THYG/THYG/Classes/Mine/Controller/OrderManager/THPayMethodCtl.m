
//
//  THPayMethodCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/6.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THPayMethodCtl.h"
#import "THPay.h"
#import "THPayMethodCell.h"
#import "THPaySuccessBlockPage.h"

@interface THPayMethodCtl () <UITableViewDataSource, UITableViewDelegate> {
     NSInteger _curSelectIndex;
}
@property (weak, nonatomic) IBOutlet UILabel *payTotalMoneyLabel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation THPayMethodCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"收银台";
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self autoLayoutSizeContentView:self.tableView];
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    self.payTotalMoneyLabel.text = [NSString stringWithFormat:@"实付款：%.2lf",self.totalPrice];
    [self.tableView registerNib:[UINib nibWithNibName:@"THPayMethodCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THPayMethodCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    NSString *imgName = @[@"bank",@"pay",@"wx"][indexPath.row];
    cell.icon.image = [UIImage imageNamed:imgName];
    cell.titleLabel.text = @[@"银行卡",@"支付宝支付",@"微信支付"][indexPath.row];
    if (indexPath.row==_curSelectIndex) {
        cell.selectStatus.selected = YES;
    }else{
        cell.selectStatus.selected = NO;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _curSelectIndex = indexPath.row;
    [tableView reloadData];
}
- (IBAction)payBtnClick:(id)sender {
    //微信支付成功回调
    [THPay weChatPay:nil success:^(id response) {
        
        [THHUDProgress showSuccess:@"微信支付成功"];
        THPaySuccessBlockPage *page = [[THPaySuccessBlockPage alloc] init];
        [self.navigationController pushViewController:page animated:YES];
    } failed:^(id errorInfo) {
        
    }];
   
    
    //支付宝支付成功回调
    [THPay aliPay:nil success:^(id response) {
        [THHUDProgress showSuccess:@"支付宝支付成功"];
        THPaySuccessBlockPage *page = [[THPaySuccessBlockPage alloc] init];
        [self.navigationController pushViewController:page animated:YES];
    } failed:^(id errorInfo) {
        
    }];
    
    
}



@end
