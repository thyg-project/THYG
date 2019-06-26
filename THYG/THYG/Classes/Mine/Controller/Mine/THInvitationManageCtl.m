//
//  THInvitationManageCtl.m
//  THYG
//
//  Created by Colin on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THInvitationManageCtl.h"
#import "THMySupplierCell.h"
#import "THRecommendedCell.h"

@interface THInvitationManageCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *mySupplierBtn;
@property (weak, nonatomic) IBOutlet UIButton *myMembersBtn;
@property (weak, nonatomic) IBOutlet UIButton *recommendedBtn;
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic,strong) NSArray<UIButton*> *btnData;
//当前的位置：1.我的供应商 2.我的注册会员 3.推荐有奖
@property (nonatomic,assign) NSInteger curIndex;
@end

@implementation THInvitationManageCtl

- (void)viewDidLoad {
    [super viewDidLoad];

    self.btnData = @[self.mySupplierBtn,self.myMembersBtn,self.recommendedBtn];
    
    [self.view addSubview:self.mTable];
}

- (IBAction)mySupplierBtnClick:(id)sender {
    
    [self btnAction:sender];
}

- (IBAction)myMembersBtnClick:(id)sender {
    
    [self btnAction:sender];
}

- (IBAction)recommendedBtnClick:(id)sender {
    
    [self btnAction:sender];
}

- (void)btnAction:(UIButton*)btn
{
    self.curIndex = btn.tag;
    
    [self.btnData enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        obj.selected = NO;
        
    }];
    
    btn.selected = YES;
    
    [self.mTable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.data.count;
    switch (self.curIndex) {
        case 1:
            return 3;
            break;
        case 2:
            return 5;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.curIndex) {
        case 1:
        case 2:
            return 110;
            break;
        case 3:
            return 120;
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (self.curIndex) {
        case 1:
        case 2:
        {
            THMySupplierCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMySupplierCell.class)];
            
            return cell;
        }
            break;
        case 3:
        {
            THRecommendedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THRecommendedCell.class)];
            
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UITableView *)mTable
{
    if (!_mTable) {
//        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, kScreenWidth, kScreenHeight-kNaviHeight-41) style:UITableViewStylePlain];
        _mTable.backgroundColor = BGColor;
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THMySupplierCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THMySupplierCell.class)];
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THRecommendedCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THRecommendedCell.class)];
    }
    return _mTable;
}

- (NSMutableArray* )data
{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

@end
