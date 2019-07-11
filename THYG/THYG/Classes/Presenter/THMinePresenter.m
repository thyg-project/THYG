//
//  THMinePresenter.m
//  THYG
//
//  Created by C on 2019/7/11.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THMinePresenter.h"

@implementation THMinePresenter

- (void)getLocailData {
  NSArray *data = @[@[@{@"image":@"", @"title":@""}],@[@{@"image":@"tuiguangerweima_red", @"title":@"推广二维码"}, @{@"image":@"gongyingzhuanyuanshenqing", @"title":@"供应专员申请"}, @{@"image":@"chengweigongyingshang", @"title":@"成为供应商"}],@[@{@"image":@"youhuiquan",@"title":@"优惠券"},@{@"image":@"qianbao",@"title":@"钱包"},],@[@{@"image":@"yaoqingguanli",@"title":@"邀请管理"},@{@"image":@"wodeguanzhu",@"title":@"我的关注"},@{@"image":@"liulanjilu",@"title":@"浏览记录"},@{@"image":@"wodetechanquan",@"title":@"我的晒单"},@{@"image":@"woderenwu",@"title":@"我的任务"}],@[@{@"image":@"",@"title":@""}],@[@{@"image":@"",@"title":@"猜你喜欢"}]];
    if ([self.delegate respondsToSelector:@selector(getLocalDataSuccess:)]) {
        [(id <THMineProtocol>)self.delegate getLocalDataSuccess:data];
    }
    
}

@end
