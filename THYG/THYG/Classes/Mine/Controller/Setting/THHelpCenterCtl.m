//
//  THHelpCenterCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHelpCenterCtl.h"
#import "THHelpCenterDetailCtl.h"

@interface THHelpCenterCtl ()

@end

@implementation THHelpCenterCtl

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self = [[UIStoryboard storyboardWithName:@"THHelpCenterCtl" bundle:nil] instantiateInitialViewController];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助中心";
    [self addBackBarItem];
    self.tableView.tableFooterView = [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    THHelpCenterDetailCtl *detail = [[THHelpCenterDetailCtl alloc] init];
    detail.loadUrl = @"https://www.baidu.com";
    [self.navigationController pushViewController:detail animated:YES];
}

@end
