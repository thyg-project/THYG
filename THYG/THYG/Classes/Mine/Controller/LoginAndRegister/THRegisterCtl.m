//
//  THRegisterCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterCtl.h"
#import "THRegisterNextStepCtl.h"
#import "Utils.h"
#import "THAlertView.h"
#import "THRegisterPresenter.h"

@interface THRegisterCtl () <THRegisterProtocol>
@property (weak, nonatomic) IBOutlet UITextField *phoneNumField;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (weak, nonatomic) IBOutlet UILabel *contactServicerLabel;
@property (nonatomic, strong) THRegisterPresenter *presenter;
@end

@implementation THRegisterCtl

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navigationItem.title = self.type ? @"忘记密码" : @"会员注册";
    _presenter = [[THRegisterPresenter alloc] initPresenterWithProtocol:self];
	self.contactServicerLabel.hidden = self.type;
    [self.nextStepBtn setBackgroundImage:[UIImage imageWithColor:RGB(213, 0, 27)] forState:UIControlStateNormal];
    [self.nextStepBtn setBackgroundImage:[UIImage imageWithColor:RGB(230,230,230)] forState:UIControlStateDisabled];
    self.nextStepBtn.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.phoneNumField];
}

- (void)textDidChanged:(NSNotification *)not {
    UITextField *textf = not.object;
    if (textf.text.length > 11) {
        self.phoneNumField.text = [textf.text substringToIndex:11];
    }
    self.nextStepBtn.enabled = [Utils checkPhoneNum:self.phoneNumField.text];
}

- (IBAction)nextBtnAction:(id)sender {
	[self.view endEditing:YES];
    kWeakSelf;
	[THAlertView alertViewWithTitle:nil content:[NSString stringWithFormat:@"我们将发送短信验证码至:\n\n%@",self.phoneNumField.text] confirmBtnTitle:@"确定" cancelBtnTitle:@"取消" confirmCallback:^{
        [THHUDProgress show];
        [weakSelf.presenter sendVerifyCode:weakSelf.phoneNumField.text type:weakSelf.type];
    } cancelCallback:^{
        
    }];
}

#pragma mark---
- (void)sendVerifyCodeFailed:(NSDictionary *)errorInfo {
    [THHUDProgress dismiss];
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)sendVerifyCodeSuccess:(NSDictionary *)response {
    [THHUDProgress dismiss];
    THRegisterNextStepCtl *nextStepCtl = [[THRegisterNextStepCtl alloc] init];
    nextStepCtl.phoneString = self.phoneNumField.text;
    nextStepCtl.uniqueId = response[@"info"][@"uniqueid"];
    nextStepCtl.isForgetPwd = self.type != 0;
    [self.navigationController pushViewController:nextStepCtl animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
