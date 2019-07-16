//
//  THModifyPwdVC.m
//  THYG
//
//  Created by Mac on 2018/5/22.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THModifyPwdVC.h"

@interface THModifyPwdVC ()
@property (weak, nonatomic) IBOutlet UITextField *originPwd;
@property (weak, nonatomic) IBOutlet UITextField *lastestPwd;
@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

@end

@implementation THModifyPwdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"修改密码";
}

#pragma mark - 修改密码
- (IBAction)okClick:(id)sender {
    if (![self checkPwd]) return;
    
//    NSDictionary *dict = @{@"token":@"",@"old_password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.originPwd.text]], @"new_password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.lastestPwd.text]], @"confirm_password":[Utils md5:[NSString stringWithFormat:@"TPSHOP%@",self.confirmPwd.text]]};

    
}

#pragma mark - 校验密码
- (BOOL)checkPwd {
    if (YGInfo.validString(self.originPwd.text) == NO) {
        [THHUDProgress showMsg:@"原密码不能为空"];
        return NO;
    }
    
    if (!YGInfo.validString(self.lastestPwd.text)) {
        [THHUDProgress showMsg:@"新密码不能为空"];
        return NO;
    }
    if (![Utils checkPassword:self.lastestPwd.text]) {
        [THHUDProgress showMsg:@"新密码格式不正确"];
        return NO;
    }
    
    if (!YGInfo.validString(self.confirmPwd.text)) {
        [THHUDProgress showMsg:@"确认密码不能为空"];
        return NO;
    }
    if (![self.confirmPwd.text isEqualToString:self.lastestPwd.text]) {
        [THHUDProgress showMsg:@"两次密码输入不一致"];
        return NO;
    }
    return YES;
    
}

@end
