//
//  THDatabaseManager.h
//  THYG
//
//  Created by C on 2019/7/17.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THMyCollectModel.h"
#import "THMessageModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface THDatabaseManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)insertCollectModel:(THMyCollectModel *)model;

- (BOOL)deleteCollectModel:(THMyCollectModel *)model;

- (BOOL)updateCollectModel:(THMyCollectModel *)model;

- (NSArray <THMyCollectModel *>*)AllCollectModels;

- (BOOL)insertMessage:(THMessageModel *)message;

- (BOOL)deleteMessage:(THMessageModel *)message;

- (BOOL)updateMessage:(THMessageModel *)message;

- (NSArray <THMessageModel *>*)allMessages;


@end

NS_ASSUME_NONNULL_END
