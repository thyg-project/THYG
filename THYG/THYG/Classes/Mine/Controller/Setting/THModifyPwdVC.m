//
//  THModifyPwdVC.m
//  THYG
//
//  Created by Mac on 2018/5/22.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THModifyPwdVC.h"
#import "THModifyPwdPresenter.h"

@interface THModifyPwdVC () <THModifyPwdProtocol>
@property (weak, nonatomic) IBOutlet UITextField *originPwd;
@property (weak, nonatomic) IBOutlet UITextField *lastestPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;
@property (nonatomic, strong) THModifyPwdPresenter *presenter;

@end

@implementation THModifyPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
    _presenter = [[THModifyPwdPresenter alloc] initPresenterWithProtocol:self];
}

#pragma mark - 修改密码
- (IBAction)okClick:(id)sender {
    [self.presenter modifyPwdOrigin:self.originPwd.text newPwd:self.lastestPwd.text confirmPwd:self.confirmPwd.text];
}

- (void)modifyPwdSuccess:(NSDictionary *)response {
    
}

- (void)modifyPwdFailed:(NSDictionary *)response {
    [THHUDProgress showMsg:response.message];
}

@end
