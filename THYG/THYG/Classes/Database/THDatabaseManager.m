//
//  THDatabaseManager.m
//  THYG
//
//  Created by C on 2019/7/17.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THDatabaseManager.h"



@interface THDatabaseManager()

@property (nonatomic, strong) RLMRealm *realm;

@end



@implementation THDatabaseManager

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
        RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
        _realm = [RLMRealm realmWithConfiguration:config error:nil];
    }
    return self;
}

- (BOOL)addObject:(RLMObject *)object {
    return [self.realm transactionWithBlock:^{
        [self.realm addObject:object];
    } error:nil];
}

- (BOOL)updateObject:(RLMObject *)object {
    BOOL result = [self.realm transactionWithBlock:^{
        [self.realm addObject:object];
    } error:nil];
    if (!result) {
        return NO;
    }
    [self.realm transactionWithBlock:^{
        [self.realm addOrUpdateObject:object];
    }];
    return YES;
}

- (BOOL)deleteObject:(RLMObject *)object {
    return [self.realm transactionWithBlock:^{
        [self.realm deleteObject:object];
    } error:nil];
}

- (NSArray <RLMObject *>*)allObject {
//    RLMResults *result = RLMObject.allObjects;
    return @[];
}

@end
