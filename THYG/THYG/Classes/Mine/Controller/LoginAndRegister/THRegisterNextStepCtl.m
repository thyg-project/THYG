//
//  THRegisterNextStepCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterNextStepCtl.h"
#import "ReactiveCocoa.h"
#import "THRegisterPresenter.h"


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
    self.navigationItem.title = @"会员注册";
    _presenter = [[THRegisterPresenter alloc] initPresenterWithProtocol:self];
    [self setTextFieldLeftPadding:self.verifyCodeField forWidth:10];
    [self setTextFieldLeftPadding:self.pswField forWidth:10];
    self.phoneNumOfRevCodeLabel.text = [NSString stringWithFormat:@"请输入%@收到的验证码",self.phoneString];
    [self getVerifyCodeAction:self.getVerifyCodeBtn];
    [self initSignal];
}

- (void)initSignal {
    RACSignal *validVerifyCodeSignal = [self.verifyCodeField.rac_textSignal map:^id(NSString *text) {
        return @(self.verifyCodeField.text.length);
    }];
    
    RACSignal *validPwdSignal = [self.pswField.rac_textSignal map:^id(NSString *text) {
        return @([Utils checkPassword:text]);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validVerifyCodeSignal, validPwdSignal] reduce:^id(NSNumber*verifyCodeValid, NSNumber *passwordValid){
        return @([verifyCodeValid boolValue] && [passwordValid boolValue]);
    }];
    
    RAC(self.finishBtn, backgroundColor) = [signUpActiveSignal map:^id(NSNumber *nextValid){
        return [nextValid boolValue] ? RGB(213, 0, 27) : RGB(230,230,230);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.finishBtn.enabled = [signupActive boolValue];
    }];
}

dispatch_source_t _source_t;
- (IBAction)getVerifyCodeAction:(id)sender {
    self.getVerifyCodeBtn.backgroundColor = RGB(230,230,230);
    [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.presenter sendVerifyCode:@""];
}

- (IBAction)finishAction:(id)sender {
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:0];

	if (self.isForgetPwd) {
		params[@"code"] = self.verifyCodeField.text;
	} else {
		params[@"mobile_code"] = self.verifyCodeField.text;
	}
	params[@"unique_id"] = self.uniqueId;
	params[@"mobile"] = self.phoneString;
	params[@"password"] = [Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]];
	params[@"confirm_password"] = [Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.pswField.text]];
    [self.presenter registerUser:@"" verifyCode:@"" pwd:@""];
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
    
}

- (void)sendVerifyCodeFailed:(NSDictionary *)errorInfo {
    
}

- (void)sendVerifyCodeSuccess:(NSDictionary *)response {
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
    
}

- (void)getUserInfoSuccess:(NSDictionary *)response {
    
}

- (void)dealloc {
    if (_source_t) {
        dispatch_source_cancel(_source_t);
    }
}

@end
