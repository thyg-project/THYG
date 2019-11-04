//
//  THTeInfoViewController.m
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THTeInfoViewController.h"
#import "THTeTableViewCell.h"
#import "THSectionView.h"

@interface THTeInfoViewController () <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    UILabel *_teLabel;
}

@end

@implementation THTeInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"领特币";
    [self setTeInfo];
    [self setup];
}

- (void)setTeInfo {
    UIView *infoView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 20)];
    infoView.backgroundColor = [UIColor clearColor];
    
    UILabel *infoLabel = [[UILabel alloc] init];
    [infoView addSubview:infoLabel];
    [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(infoView);
    }];
    _teLabel = infoLabel;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoView];
    [self setTeLabel:200];
}

- (void)setTeLabel:(NSInteger)te {
    NSString *string = [NSString stringWithFormat:@"我的特币：%@",@(te).stringValue];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:string];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:UIColorHex(0xffffff)} range:NSMakeRange(0, string.length - @(te).stringValue.length)];
    [att addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:UIColorHex(0xFDDB4E)} range:[string rangeOfString:@(te).stringValue]];
    _teLabel.attributedText = att;
}

- (void)setup {
    UIImageView *topImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"签到领特币banner2"]];
    
    UIImageView *signImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"签到按钮"] highlightedImage:[UIImage imageNamed:@""]];
    [topImageView addSubview:signImageView];
    signImageView.userInteractionEnabled = YES;
    [signImageView addGestureRecognizer:({
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sign)];
        tap;
    })];
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    UIView *temp = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 258)];
    temp.backgroundColor = [UIColor clearColor];
    [temp addSubview:topImageView];
    _tableView.tableHeaderView = temp;
    [self autoLayoutSizeContentView:_tableView];
    [self.view addSubview:_tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    [_tableView registerClass:[THTePTableViewCell class] forCellReuseIdentifier:@"pCell"];
    [_tableView registerClass:[THTeDBTableViewCell class] forCellReuseIdentifier:@"dbCell"];
    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(temp);
        make.height.mas_equalTo(250);
    }];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)sign {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = nil;
    if (indexPath.section == 0) {
        identifier = @"dbCell";
    } else {
        identifier = @"pCell";
    }
    THTeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 96 + 16 + 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 38;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 16;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    THSectionFooter *footer = [[THSectionFooter alloc] initWithFrame:CGRectMake(16, 0, kScreenWidth -32, 16)];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    THSectionView *header = [[THSectionView alloc] initWithFrame:CGRectMake(16, 0, kScreenWidth - 32, 38)];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
