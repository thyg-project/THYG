//
//  THAboutTHCtl.m
//  THYG
//
//  Created by 廖辉 on 2018/6/9.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THAboutTHCtl.h"

@interface THAboutTHCtl ()
@property (weak, nonatomic) IBOutlet UILabel *curVersionLabel;

@end

@implementation THAboutTHCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"关于特汇易购";
    self.curVersionLabel.text = [NSString stringWithFormat:@"当前版本：v%@",YGInfo.appVersion()];
}

@end
