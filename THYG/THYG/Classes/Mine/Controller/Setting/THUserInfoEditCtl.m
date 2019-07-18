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

@interface THUserInfoEditCtl () <THSelectTimeViewDelegate, UITextFieldDelegate>
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
    self.nickNameLabel.delegate = self.professionalField.delegate = self;
    kWeakSelf;
    self.timeView.selectedTimeBlock = ^(NSString *year, NSString *month, NSString *day) {
        [weakSelf.yearBtn setTitle:year forState:UIControlStateNormal];
        [weakSelf.monthBtn setTitle:month forState:UIControlStateNormal];
        [weakSelf.dayBtn setTitle:day forState:UIControlStateNormal];
        NSString *time = [[[year substringToIndex:year.length-1] stringByAppendingString:[month substringToIndex:month.length-1]] stringByAppendingString:[day substringToIndex:day.length-1]];
        weakSelf.params[@"birthday"] = @([time integerValue]);
    };
    
    self.categoryView.selectedItemBlock = ^(NSString *category) {
        if (weakSelf.isSelectedSex) {
            [weakSelf.sexBtn setTitle:category forState:UIControlStateNormal];
            weakSelf.params[@"sex"] = [category isEqualToString:@"男"] ? @"1" : @"2";
        } else {
            [weakSelf.categoryBtn setTitle:category forState:UIControlStateNormal];
            weakSelf.params[@"favorite_cat"] = category;
        }
    };
}

#pragma mark - 上传头像
- (IBAction)uploadImage:(id)sender {
    
}

#pragma mark - 选择性别
- (IBAction)sexBtnClick:(id)sender {
    _isSelectedSex = YES;
    self.categoryView.dataArray = @[@"男",@"女"];
    [self.categoryView show];
}

#pragma mark - 选择时间
- (IBAction)timeClick:(id)sender {
    [self.timeView show];
}

#pragma mark - 选择分类
- (IBAction)categoryBtnClick:(id)sender {
    _isSelectedSex = NO;
    self.categoryView.dataArray = self.dataSourceArray;
    [self.categoryView show];
}

#pragma mark - 确认修改
- (IBAction)okClick {

}

- (void)dismiss {
    [self.timeView removeFromSuperview];
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
        _timeView = [THSelectTimeView sharedInstance];
        _timeView.delegate = self;
    }
    return _timeView;
}

- (THSelectedCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [THSelectedCategoryView sharedInstance];
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
