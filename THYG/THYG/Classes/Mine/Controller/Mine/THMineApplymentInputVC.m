//
//  THMineApplymentInputVC.m
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineApplymentInputVC.h"
#import "THApplyInputPresenter.h"

@interface THMineApplymentInputVC () <UITextFieldDelegate, THApplyInputProtocol>
@property (weak, nonatomic) IBOutlet UITextField *applyAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirePwdTF;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *weChatTF;
@property (weak, nonatomic) IBOutlet UITextField *vipNameTF;
@property (weak, nonatomic) IBOutlet UITextField *applyUserID;
@property (nonatomic, strong) THApplyInputPresenter *presenter;

@end

@implementation THMineApplymentInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请成为供应商";
    _presenter = [[THApplyInputPresenter alloc] initPresenterWithProtocol:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.applyAccountTF) {
        [self.pwdTF becomeFirstResponder];
    } else if (textField == self.pwdTF) {
        [self.confirePwdTF becomeFirstResponder];
    } else if (textField == self.confirePwdTF) {
        [self.areaTF becomeFirstResponder];
    } else if (textField == self.areaTF) {
        [self.nameTF becomeFirstResponder];
    } else if (textField == self.nameTF) {
        [self.mobileTF becomeFirstResponder];
    } else if (textField == self.mobileTF) {
        [self.weChatTF becomeFirstResponder];
    } else if (textField == self.weChatTF) {
        [self.vipNameTF becomeFirstResponder];
    } else if (textField == self.vipNameTF) {
        [self.applyUserID becomeFirstResponder];
    } else if (textField == self.applyUserID) {
        [self.view endEditing:YES];
        [self.presenter applyInfoWithAccount:self.applyAccountTF.text pwd:self.pwdTF.text confirmPwd:self.confirePwdTF.text area:self.areaTF.text name:self.nameTF.text mobile:self.mobileTF.text wechatID:self.weChatTF.text vipName:self.vipNameTF.text applyID:self.applyUserID.text];
        return NO;
    }
    return YES;
}

- (void)applyFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)applySuccess:(NSDictionary *)response {
    
}

@end
