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
    NSArray *data = @[ @[@{@"image":@"dingliangtuantubiao",@"mobile_name":@"定量团"},@{@"image":@"pintuantubiao",@"mobile_name":@"拼团"},@{@"image":@"miaoshatubiao",@"mobile_name":@"秒杀"}],@[@{@"image":@"mjmc",@"title":@"名酒茗茶"},@{@"image":@"yszb",@"title":@"滋生养补"},@{@"image":@"msxc",@"title":@"美食小吃"},@{@"image":@"lysp",@"title":@"粮油食品"},@{@"image":@"hxsc",@"title":@"海鲜水产"},@{@"image":@"rldp",@"title":@"肉类蛋品"},@{@"image":@"scgg",@"title":@"蔬菜瓜果"},@{@"image":@"yxsg",@"title":@"优选水果"}],@[@{}]];
    [self performToSelector:@selector(loadLocalizedSuccess:) params:data];
}

- (void)searchDataWithContent:(NSString *)content {
    NSURLSessionTask *task = [YGNetworkCommon login:content psd:nil success:^(id responseObject) {
        [self performToSelector:@selector(searchSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(searchFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
