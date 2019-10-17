//
//  THMineSubmitApplicationVC.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineSubmitApplicationVC.h"
#import "THInputApplyInfoPresenter.h"

@interface THMineSubmitApplicationVC () <THInputApplyInfoProtocol, UITextFieldDelegate>
@property (nonatomic, strong) IBOutlet UIButton *submitButton;
@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *iDNumberField;
@property (nonatomic, strong) IBOutlet UITextField *phoneField;
@property (nonatomic, strong) IBOutlet UITextField *weiChatField;
@property (nonatomic, strong) THInputApplyInfoPresenter *presenter;
@end

@implementation THMineSubmitApplicationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"填写申请资料";
    self.submitButton.layer.borderColor = RGB(213, 0, 27).CGColor;
    _presenter = [[THInputApplyInfoPresenter alloc] initPresenterWithProtocol:self];
}

- (IBAction)submitClick {
    [self.presenter applyInfoWithUsername:self.nameField.text identifier:self.iDNumberField.text mobile:self.phoneField.text wechatID:self.weiChatField.text];
}

- (void)inputApplyInfoFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)inputApplyInfoSuccess:(NSDictionary *)response {
    [THHUDProgress showMessage:response.message];
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.nameField) {
        [self.iDNumberField becomeFirstResponder];
    } else if (textField == self.iDNumberField) {
        [self.phoneField becomeFirstResponder];
    } else if (textField == self.phoneField) {
        [self.weiChatField becomeFirstResponder];
    } else if (textField == self.weiChatField) {
        [self.view endEditing:YES];
        [self.presenter applyInfoWithUsername:self.nameField.text identifier:self.iDNumberField.text mobile:self.phoneField.text wechatID:self.weiChatField.text];
        return NO;
    }
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end
