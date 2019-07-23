//
//  THUserInfoEditCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUserInfoEditCtl.h"
#import "THSelectTimeView.h"
#import "THSelectedCategoryView.h"

@interface THUserInfoEditCtl () <THSelectTimeViewDelegate, UITextFieldDelegate, THCategoryDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UITextField *professionalField; // 职业
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (nonatomic, strong) THSelectTimeView *timeView;
@property (nonatomic, strong) THSelectedCategoryView *categoryView;
@property (assign, nonatomic) BOOL isSelectedSex;
@property (nonatomic, copy) NSMutableDictionary *params;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;

@end

@implementation THUserInfoEditCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息编辑";
    self.nickNameLabel.delegate = self.professionalField.delegate = self;
    
}

#pragma mark - 上传头像
- (IBAction)uploadImage:(id)sender {
    
}

#pragma mark - 选择性别
- (IBAction)sexBtnClick:(id)sender {
    _isSelectedSex = YES;
    self.categoryView.dataArray = @[@"男",@"女"];
    [self.categoryView showInView:self.view];
}

#pragma mark - 选择时间
- (IBAction)timeClick:(id)sender {
    [self.timeView showInView:self.view];
}

#pragma mark - 选择分类
- (IBAction)categoryBtnClick:(id)sender {
    _isSelectedSex = NO;
    self.categoryView.dataArray = self.dataSourceArray;
    [self.categoryView showInView:self.view];
}

#pragma mark - 确认修改
- (IBAction)okClick {

}

- (void)dismiss {
    
}

- (void)selectedItemWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    [self.yearBtn setTitle:year forState:UIControlStateNormal];
    [self.monthBtn setTitle:month forState:UIControlStateNormal];
    [self.dayBtn setTitle:day forState:UIControlStateNormal];
    NSString *time = [[[year substringToIndex:year.length-1] stringByAppendingString:[month substringToIndex:month.length-1]] stringByAppendingString:[day substringToIndex:day.length-1]];
    self.params[@"birthday"] = @([time integerValue]);
}

- (void)dismiss:(THSelectedCategoryView *)view {
    
}

- (void)catogoryView:(THSelectedCategoryView *)category didSelectedItem:(NSString *)item {
    if (self.isSelectedSex) {
        [self.sexBtn setTitle:item forState:UIControlStateNormal];
        self.params[@"sex"] = [item isEqualToString:@"男"] ? @"1" : @"2";
    } else {
        [self.categoryBtn setTitle:item forState:UIControlStateNormal];
        self.params[@"favorite_cat"] = item;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.nickNameLabel == textField) {
        _params[@"nickname"] = textField.text;
    } else {
        _params[@"job"] = textField.text;
    }
    return YES;
}

#pragma mark - 懒加载
- (THSelectTimeView *)timeView {
    if (!_timeView) {
        _timeView = [THSelectTimeView new];
        _timeView.delegate = self;
    }
    return _timeView;
}

- (THSelectedCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [THSelectedCategoryView new];
        _categoryView.delegate = self;
    }
    return _categoryView;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _params;
}

@end
