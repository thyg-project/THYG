//
//  THDatabaseManager.m
//  THYG
//
//  Created by C on 2019/7/17.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THDatabaseManager.h"
#import <FMDB/FMDB.h>


static NSString *const kGoodsDBName = @"goods.db";

@interface THDatabaseManager()

@property (nonatomic, strong) FMDatabase *database;

@property (nonatomic, copy) NSString *goodsPath;

@end



@implementation THDatabaseManager

- (NSString *)goodsPath {
    if (!_goodsPath) {
        NSString *docuPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _goodsPath = [docuPath stringByAppendingPathComponent:kGoodsDBName];
    }
    return _goodsPath;
}

+ (instancetype)sharedInstance {
    static THDatabaseManager *m = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        m = [[self alloc] init];
    });
    return m;
}

- (instancetype)init {
    if (self = [super init]) {
        _database = [FMDatabase databaseWithPath:self.goodsPath];
        if ([_database open]) {
            NSString *sql = @"create table if not exists t_goods ()";
            BOOL result = [_database executeUpdate:sql];
            if (result) {
                NSLog(@"create table success");
            }
        }
        [_database close];
       
    }
    return self;
}

- (BOOL)insertCollectModel:(id)model {
    return YES;
}

- (BOOL)deleteCollectModel:(id)model {
    return YES;
}

- (BOOL)updateCollectModel:(id)model {
    return YES;
}

- (NSArray *)AllCollectModels {
    return nil;
}

- (BOOL)insertMessage:(id)message {
    return YES;
}

- (BOOL)deleteMessage:(id)message {
    return YES;
}

- (BOOL)updateMessage:(id)message {
    return YES;
}

- (NSArray *)AllMessages {
    return nil;
}

- (NSArray *)messagesWithCondition:(id)condition {
    return nil;
}



@end
