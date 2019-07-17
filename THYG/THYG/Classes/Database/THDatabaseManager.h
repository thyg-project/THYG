//
//  THDatabaseManager.h
//  THYG
//
//  Created by C on 2019/7/17.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface THDatabaseManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)addObject:(RLMObject *)object;

- (BOOL)updateObject:(RLMObject *)object;

- (BOOL)deleteObject:(RLMObject *)object;

- (NSArray <RLMObject *>*)allObject;

@end

NS_ASSUME_NONNULL_END
