//
//  THRegisterNextStepCtl.m
//  THYG
//
//  Created by Colin on 2018/3/27.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THRegisterNextStepCtl.h"
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.verifyCodeField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextFieldTextDidChangeNotification object:self.pswField];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:RGB(213, 0, 27)] forState:UIControlStateNormal];
    [self.finishBtn setBackgroundImage:[UIImage imageWithColor:RGB(230,230,230)] forState:UIControlStateDisabled];
    self.finishBtn.enabled = NO;
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
    [self.presenter sendVerifyCode:@""];
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
