//
//  THCouponsCtl.m
//  THYG
//
//  Created by Colin on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THCouponsCtl.h"
#import "THCouponsModel.h"
#import "THCouponsCell.h"

@interface THCouponsCtl ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *allBtn;
@property (weak, nonatomic) IBOutlet UIButton *generalBtn;
@property (weak, nonatomic) IBOutlet UIButton *specifiedBtn;
@property (weak, nonatomic) IBOutlet UIButton *screeningBtn;
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic,strong) NSArray<UIButton*> *btnData;
@property (nonatomic,strong) NSMutableArray *canGetData;
@property (nonatomic,strong) NSMutableArray *getedData;
@property (nonatomic,strong) UIButton *titleBtnView;
@property (nonatomic,strong) THCouponsTypeSelectView *selectView;
@property (nonatomic,assign) NSInteger type;//0.我的优惠券 1.领券中心
@end

@implementation THCouponsCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠券";
    self.btnData = @[self.allBtn,self.generalBtn,self.specifiedBtn,self.screeningBtn];
    
    self.navigationItem.titleView = self.titleBtnView;
    
    [self.view addSubview:self.mTable];
    [self.view addSubview:self.selectView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.type?self.canGetData.count:self.getedData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCouponsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THCouponsCell.class)];
    [cell refreshWithModel:self.type?self.canGetData[indexPath.row]:self.getedData[indexPath.row] type:self.type];
    cell.btnClickAcion = ^{
      
        //领取优惠券
        if (self.type) {
            
        }else{
            //使用优惠券
        }
        
    };
    return cell;
}

- (void)btnClick {
    if (self.titleBtnView.selected) {
        [self.selectView hidden];
        self.titleBtnView.selected = NO;
        return;
    }
    [self.selectView show];
    self.titleBtnView.selected = YES;
}

- (IBAction)allBtnClick:(UIButton*)sender {
    
    [self btnClick:sender];
}

- (IBAction)generalBtnClick:(UIButton*)sender {
    
    [self btnClick:sender];
}

- (IBAction)specifiedBtnClick:(UIButton*)sender {
    
    [self btnClick:sender];
}

- (IBAction)screeningBtnClick:(UIButton*)sender {
    
    [self btnClick:sender];
}

- (void)btnClick:(UIButton*)sender {
    [self.btnData enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        obj.selected = NO;
    }];
    sender.selected = YES;
}


- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 41, kScreenWidth, kScreenHeight-kNaviHeight-40) style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        _mTable.allowsSelection = NO;
        [_mTable registerNib:[UINib nibWithNibName:NSStringFromClass(THCouponsCell.class) bundle:nil] forCellReuseIdentifier:NSStringFromClass(THCouponsCell.class)];
    }
    return _mTable;
}

- (THCouponsTypeSelectView *)selectView {
    if (!_selectView) {
        _selectView = [[THCouponsTypeSelectView alloc] init];
        kWeakSelf;
        _selectView.selectTypeAction = ^(NSInteger type, NSString *title) {
            
            weakSelf.titleBtnView.selected = NO;
            
            [weakSelf.titleBtnView setTitle:title forState:UIControlStateNormal];
            weakSelf.type = type;
            [weakSelf.mTable reloadData];
            
        };
    }
    return _selectView;
}

- (UIButton*)titleBtnView {
    if (!_titleBtnView) {
        _titleBtnView = [UIButton buttonWithType:UIButtonTypeCustom];
        _titleBtnView.frame = CGRectMake(0, 0, 100, 40);
        [_titleBtnView setTitle:@"我的优惠券" forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [_titleBtnView setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        _titleBtnView.titleLabel.font = Font(15);
        [_titleBtnView addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleBtnView;
}

- (NSMutableArray*)canGetData {
    if (!_canGetData) {
        _canGetData = [[NSMutableArray alloc] init];
    }
    return _canGetData;
}

- (NSMutableArray*)getedData {
    if (!_getedData) {
        _getedData = [[NSMutableArray alloc] init];
    }
    return _getedData;
}

@end


@interface THCouponsTypeSelectView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mTable;
@property (nonatomic,strong) NSArray *data;
@end

@implementation THCouponsTypeSelectView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.data = @[@"我的优惠券",@"领券中心"];
        [self addSubview:self.mTable];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        self.mTable.frame = CGRectMake(0, 0, kScreenWidth, 0);
        self.frame = CGRectMake(0, 0, kScreenWidth, 0);
        [self addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)show {
    self.height = kScreenHeight;
    [UIView animateWithDuration:0.3 animations:^{
        self.mTable.height = 45*self.data.count;
    }];
}

- (void)hidden {
    [UIView animateWithDuration:0.3 animations:^{
        self.mTable.height = 0;
    } completion:^(BOOL finished) {
        self.height = 0;
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.font = Font(15);
    cell.textLabel.text = self.data[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self hidden];
    if (self.selectTypeAction) {
        self.selectTypeAction(indexPath.row,self.data[indexPath.row]);
    }
}

- (UITableView *)mTable {
    if (!_mTable) {
        _mTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0) style:UITableViewStylePlain];
        _mTable.delegate = self;
        _mTable.dataSource = self;
        _mTable.backgroundColor = BGColor;
        _mTable.tableFooterView = [UIView new];
        [_mTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _mTable;
}

@end
