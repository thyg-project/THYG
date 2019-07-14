//
//  NSMutableDictionary+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/22.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableDictionary+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableDictionary (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class dictionaryM = NSClassFromString(@"__NSDictionaryM");
        
        //setObject:forKey:
        [AvoidCrash exchangeInstanceMethod:dictionaryM
                                method1Sel:@selector(setObject:forKey:)
                                method2Sel:@selector(avoidCrashSetObject:forKey:)];
        
        
        //removeObjectForKey:
        [AvoidCrash exchangeInstanceMethod:dictionaryM
                                method1Sel:@selector(removeObjectForKey:)
                                method2Sel:@selector(avoidCrashRemoveObjectForKey:)];
    });
}


//=================================================================
//                       setObject:forKey:
//=================================================================
#pragma mark - setObject:forKey:

- (void)avoidCrashSetObject:(id)anObject forKey:(id<NSCopying>)aKey {
    // 这里 key 也 不可以为 nil
    if (!anObject || !aKey) {
        NSString *reson = [NSString stringWithFormat:@"attempt to set nil object(%@) or nil key(%@) to NSMutableDictionary",anObject, aKey];
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:reson
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashSetObject:anObject forKey:aKey];
}

//=================================================================
//                       removeObjectForKey:
//=================================================================
#pragma mark - removeObjectForKey:

- (void)avoidCrashRemoveObjectForKey:(id)aKey {
    // 这里 key 可以不包含在 allkey中，仅仅是不可以为 nil
    if (!aKey) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"Not to remove object for nil key to NSMutableDictionary"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashRemoveObjectForKey:aKey];
}

@end
