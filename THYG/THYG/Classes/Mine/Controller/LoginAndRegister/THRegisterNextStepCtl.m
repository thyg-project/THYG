//
//  THRegisterNextStepCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterNextStepCtl.h"
#import "ReactiveCocoa.h"


@interface THRegisterNextStepCtl ()
@property (weak, nonatomic) IBOutlet UILabel *phoneNumOfRevCodeLabel;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

@end

@implementation THRegisterNextStepCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员注册";
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
        return [nextValid boolValue] ? GLOBAL_RED_COLOR : GRAY_COLOR(230);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.finishBtn.enabled = [signupActive boolValue];
    }];
}

dispatch_source_t _source_t;
- (IBAction)getVerifyCodeAction:(id)sender {
    
    self.getVerifyCodeBtn.backgroundColor = GRAY_COLOR(230);
    [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [Utils scheduledCountdown:^(BOOL stop, NSTimeInterval inertval, dispatch_source_t source_t) {
        _source_t = source_t;
        if (stop) {
            [self.getVerifyCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            self.getVerifyCodeBtn.backgroundColor = GLOBAL_RED_COLOR;
        } else {
            [self.getVerifyCodeBtn setTitle:@(inertval).stringValue forState:UIControlStateNormal];
        }
    } totalTimeInterval:60];
}

- (IBAction)finishAction:(id)sender {
	
//    NSString *url = self.isForgetPwd ? @"/User/set_pwd" : @"/Login/register";
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
	
}

- (void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth {
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}

- (void)dealloc {
    if (_source_t) {
        dispatch_source_cancel(_source_t);
    }
}

@end
