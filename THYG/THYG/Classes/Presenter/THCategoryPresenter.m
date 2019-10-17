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
    NSMutableArray *list = [NSMutableArray new];
    for (NSArray <NSDictionary *> *l in data) {
        NSMutableArray *li = [NSMutableArray new];
        for (NSDictionary *d in l) {
            THCatogoryModel *model = [THCatogoryModel modelWithJSON:d];
            [li addObject:model];
            if (d[@"title"]) {
                model.title = d[@"title"];
            }
        }
        [list addObject:li];
    }
    
    [self performToSelector:@selector(loadLocalizedSuccess:) params:list.copy];
}

- (void)searchDataWithContent:(NSString *)content {
    NSURLSessionTask *task = [YGNetworkCommon searchWithKeyWord:content success:^(id responseObject) {
        [self performToSelector:@selector(searchSuccess:) params:responseObject];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(searchFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

- (void)getCategory {
    NSURLSessionTask *task = [YGNetworkCommon goodsCategory:^(id responseObject) {
        NSArray *array = [NSArray modelArrayWithClass:[THCatogoryModel class] json:responseObject[@"info"]];
        [self performToSelector:@selector(loadCatogorySuccess:) params:array];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(loadCatogoryFailed:) params:errorInfo];
    }];
    [self getTask:task];
}

@end
