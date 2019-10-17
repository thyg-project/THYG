//
//  THCatogoryProtocol.h
//  THYG
//
//  Created by C on 2019/7/14.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseProtocol.h"
#import "THCatogoryModel.h"

@protocol THCategoryProtocol <THBaseProtocol>

- (void)loadLocalizedSuccess:(NSArray <NSArray <THCatogoryModel *> *> *)data;


- (void)searchSuccess:(id)result;

- (void)searchFailed:(id)errorInfo;


- (void)loadCatogorySuccess:(NSArray <THCatogoryModel *> *)response;

- (void)loadCatogoryFailed:(NSDictionary *)errorInfo;

@end


