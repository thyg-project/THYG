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

//@property (nonatomic, strong) FMDatabase *database;

@property (nonatomic, strong) FMDatabaseQueue *databaseQueue;

@property (nonatomic, copy) NSString *goodsPath;

@end



@implementation THDatabaseManager

- (FMDatabaseQueue *)databaseQueue {
    if (!_databaseQueue) {
        _databaseQueue = [FMDatabaseQueue databaseQueueWithPath:self.goodsPath];
    }
    return _databaseQueue;
}

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
        NSString *goodsSql = @"";
        NSString *feverateSql = @"";
        NSString *historySql = @"";
        
        [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            [db open];
            [db beginTransaction];
            if (![db executeUpdate:goodsSql]) {
                NSLog(@"打开/创建商品表失败：%@",[db lastErrorMessage]);
            }
            if (![db executeUpdate:feverateSql]) {
                NSLog(@"打开/创建收藏表失败：%@",[db lastErrorMessage]);
            }
            if (![db executeUpdate:historySql]) {
                NSLog(@"打开/创建历史表失败：%@",[db lastErrorMessage]);
            }
            [db commit];
            [db close];
        }];
    }
    return self;
}

- (BOOL)insertCollectModel:(THMyCollectModel *)model {
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeUpdate:@""];
        [db close];
    }];
    return result;
}

- (BOOL)deleteCollectModel:(THMyCollectModel *)model {
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeUpdate:@""];
        [db close];
    }];
    return result;
}

- (BOOL)updateCollectModel:(THMyCollectModel *)model {
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeUpdate:@""];
        [db close];
    }];
    return result;
}

- (NSArray <THMyCollectModel *>*)AllCollectModels {
    NSMutableArray <THMyCollectModel *> *models = [NSMutableArray new];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        FMResultSet *set = [db executeQuery:@""];
        while ([set next]) {
            
        }
        [db close];
    }];
    return [models copy];
}

- (BOOL)insertMessage:(THMessageModel *)message {
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeUpdate:@""];
        [db close];
    }];
    return result;
}

- (BOOL)deleteMessage:(THMessageModel *)message {
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeUpdate:@""];
        [db close];
    }];
    return result;
}

- (BOOL)updateMessage:(THMessageModel *)message {
    __block BOOL result = NO;
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        result = [db executeUpdate:@""];
        [db close];
    }];
    return result;
}

- (NSArray <THMessageModel *>*)allMessages {
    NSMutableArray <THMessageModel *> *models = [NSMutableArray new];
    [self.databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        [db open];
        FMResultSet *set = [db executeQuery:@""];
        while ([set next]) {
            
        }
        [db close];
    }];
    return [models copy];
}




@end
