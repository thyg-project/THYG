//
//  THLoginVC.m
//  THYG
//
//  Created by Victory on 2018/3/19.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THLoginVC.h"
#import "THRegisterCtl.h"
#import "THForgetPswCtl.h"
#import "Utils.h"
#import "THLoginPresenter.h"

@interface THLoginVC () <THLoginProtocol, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, strong) THLoginPresenter *presenter;
@end

@implementation THLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员登录";
    _presenter = [[THLoginPresenter alloc] initPresenterWithProtocol:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.accountField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.pswField];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:RGB(213, 0, 27)] forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:RGB(230,230,230)] forState:UIControlStateDisabled];
    self.loginBtn.enabled = NO;
}

- (void)textDidChanged:(NSNotification *)not {
    UITextField *textf = not.object;
    if (textf == self.accountField && textf.text.length > 11) {
        self.accountField.text = [textf.text substringToIndex:11];
    }
    if ([Utils checkPhoneNum:self.accountField.text] && [Utils checkPassword:self.pswField.text]) {
        self.loginBtn.enabled = YES;
    } else {
        self.loginBtn.enabled = NO;
    }
}

- (IBAction)loginAction:(id)sender {
    [self.view endEditing:YES];
    [self.presenter loginMobile:self.accountField.text pwd:self.pswField.text];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (IBAction)registerAction:(id)sender {
    THRegisterCtl *registerCtl = [[THRegisterCtl alloc] init];
    registerCtl.type = THRegisterCtlTypeRegister;
    [self.navigationController pushViewController:registerCtl animated:YES];
}

- (IBAction)forgetPswAction:(id)sender {
    THRegisterCtl *registerCtl = [[THRegisterCtl alloc] init];
    registerCtl.type = THRegisterCtlTypeForgetPwd;
    [self.navigationController pushViewController:registerCtl animated:YES];
}

#pragma mark -
- (void)loginSuccess:(NSDictionary *)response {
    [self.presenter getUserInfo];
}

- (void)loginFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getUserInfoFailed:(NSDictionary *)errorInfo {
    
}

- (void)getUserInfoSuccess:(NSDictionary *)response {
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
