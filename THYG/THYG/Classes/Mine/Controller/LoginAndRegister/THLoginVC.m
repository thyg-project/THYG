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
#import "ReactiveCocoa.h"


@interface THLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pswField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation THLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"会员登录";
    [self initSignal];
}

- (void)initSignal {
    RACSignal *validPhoneSignal = [self.accountField.rac_textSignal map:^id(NSString *text) {
        return @([Utils CheckPhoneNum:text]);
    }];
    
    RACSignal *validPwdSignal = [self.pswField.rac_textSignal map:^id(NSString *text) {
        return @([Utils checkPassword:text]);
    }];
    
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validPhoneSignal, validPwdSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    
    RAC(self.loginBtn, backgroundColor) = [signUpActiveSignal map:^id(NSNumber *nextValid){
        return [nextValid boolValue] ? GLOBAL_RED_COLOR : GRAY_COLOR(230);
    }];
    
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive){
        self.loginBtn.enabled = [signupActive boolValue];
    }];
    
}

- (IBAction)loginAction:(id)sender {  
    

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



@end
