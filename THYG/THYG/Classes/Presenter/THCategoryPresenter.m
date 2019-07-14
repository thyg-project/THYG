//
//  THCategoryPresenter.m
//  THYG
//
//  Created by C on 2019/7/14.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCategoryPresenter.h"

@implementation THCategoryPresenter

- (void)loadLocalizedData {
    NSArray *data = @[ @[@{@"image":@"dingliangtuantubiao",@"mobile_name":@"定量团"},@{@"image":@"pintuantubiao",@"mobile_name":@"拼团"},@{@"image":@"miaoshatubiao",@"mobile_name":@"秒杀"}],@[@{@"image":@"mjmc",@"title":@"名酒茗茶"},@{@"image":@"zsyb",@"title":@"滋生养补"},@{@"image":@"msxc",@"title":@"美食小吃"},@{@"image":@"lysp",@"title":@"粮油食品"},@{@"image":@"hxsc",@"title":@"海鲜水产"},@{@"image":@"rldp",@"title":@"肉类蛋品"},@{@"image":@"scgg",@"title":@"蔬菜瓜果"},@{@"image":@"yxsg",@"title":@"优选水果"}],@[@{}]];
    if ([self.delegate respondsToSelector:@selector(loadLocalizedSuccess:)]) {
        [(id <THCategoryProtocol>)self.delegate loadLocalizedSuccess:data];
    }
}

@end
