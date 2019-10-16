//
//  THRegisterNextStepCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterNextStepCtl.h"
#import "THRegisterPresenter.h"
#import "THLoginVC.h"

@interface THRegisterNextStepCtl () <THRegisterProtocol>
@property (weak, nonatomic) IBOutlet UILabel *phoneNumOfRevCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (nonatomic, strong) THRegisterPresenter *presenter;

@end

@implementation THRegisterNextStepCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.isForgetPwd ? @"找回密码" : @"会员注册";
    _presenter = [[THRegisterPresenter alloc] initPresenterWithProtocol:self];
    [self setTextFieldLeftPadding:self.verifyCodeField forWidth:10];
    [self setTextFieldLeftPadding:self.pswField forWidth:10];
    self.phoneNumOfRevCodeLabel.text = [NSString stringWithFormat:@"请输入%@收到的验证码",self.phoneString];
//    [self getVerifyCodeAction:self.getVerifyCodeBtn];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.verifyCodeField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.pswField];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:RGB(213, 0, 27)] forState:UIControlStateNormal];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:RGB(230,230,230)] forState:UIControlStateDisabled];
    self.finishBtn.enabled = NO;
    [Utils scheduledCountdown:^(BOOL stop, NSTimeInterval inertval, dispatch_source_t source_t) {
           _source_t = source_t;
           if (stop) {
               [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
               self.getVerifyCodeBtn.backgroundColor = RGB(213, 0, 27);
           } else {
               [self.getVerifyCodeBtn setTitle:@(inertval).stringValue forState:UIControlStateNormal];
           }
       } totalTimeInterval:60];
}

- (void)textDidChanged:(NSNotification *)not {
    UITextField *textf = not.object;
    if (textf == self.verifyCodeField && textf.text.length > 6) {
        self.verifyCodeField.text = [textf.text substringToIndex:6];
    }
    if (YGInfo.validString(self.verifyCodeField.text) && [Utils checkPassword:self.pswField.text]) {
        self.finishBtn.enabled = YES;
    } else {
        self.finishBtn.enabled = NO;
    }
}

dispatch_source_t _source_t;
- (IBAction)getVerifyCodeAction:(id)sender {
    self.getVerifyCodeBtn.backgroundColor = RGB(230,230,230);
    [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [THHUDProgress show];
    [self.presenter sendVerifyCode:self.phoneString type:self.isForgetPwd ? 1 : 0];
}

- (IBAction)finishAction:(id)sender {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];
	if (self.isForgetPwd) {
        [params setValue:self.verifyCodeField.text forKey:@"code"];
	} else {
        [params setValue:self.verifyCodeField.text forKey:@"mobile_code"];
	}
    [params setValue:self.uniqueId forKey:@"unique_id"];
    [params setValue:self.phoneString forKey:@"mobile"];
    [params setValue:[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]] forKey:@"password"];
    [params setValue:[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]] forKey:@"confirm_password"];
    [THHUDProgress show];
    if (self.isForgetPwd) {
        [self.presenter forgetPwd:params];
    } else {
        [self.presenter registerUser:params];
    }
}

- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth {
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

#pragma mark ---
- (void)registerSuccess:(NSDictionary *)response {
    [self.presenter getUserInfo];
}

- (void)registerFailed:(NSDictionary *)errorInfo {
    [THHUDProgress dismiss];
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)sendVerifyCodeFailed:(NSDictionary *)errorInfo {
    [THHUDProgress dismiss];
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)sendVerifyCodeSuccess:(NSDictionary *)response {
    [THHUDProgress dismiss];
    [Utils scheduledCountdown:^(BOOL stop, NSTimeInterval inertval, dispatch_source_t source_t) {
        _source_t = source_t;
        if (stop) {
            [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.getVerifyCodeBtn.backgroundColor = RGB(213, 0, 27);
        } else {
            [self.getVerifyCodeBtn setTitle:@(inertval).stringValue forState:UIControlStateNormal];
        }
    } totalTimeInterval:60];
}

- (void)getUserInfoFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)getUserInfoSuccess:(NSDictionary *)response {
    [THHUDProgress showMessage:response.message];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)findPwdFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)findPwdSuccess:(NSDictionary *)response {
    [THHUDProgress showMessage:response.message];
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[THLoginVC class]]) {
            [self.navigationController popToViewController:vc animated:YES];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_source_t) {
        dispatch_source_cancel(_source_t);
    }
}

@end
