//
//  THMineApplymentInputVC.m
//  THYG
//
//  Created by Mac on 2018/4/20.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineApplymentInputVC.h"

@interface THMineApplymentInputVC ()
@property (weak, nonatomic) IBOutlet UITextField *applyAccountTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirePwdTF;
@property (weak, nonatomic) IBOutlet UITextField *areaTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTF;
@property (weak, nonatomic) IBOutlet UITextField *weChatTF;
@property (weak, nonatomic) IBOutlet UITextField *vipNameTF;
@property (weak, nonatomic) IBOutlet UITextField *applyUserID;

@end

@implementation THMineApplymentInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"申请成为供应商";
}

@end
