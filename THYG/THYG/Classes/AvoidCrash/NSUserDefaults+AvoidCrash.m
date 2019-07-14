//
//  NSUserDefaults+AvoidCrash.m
//  NativeEastNews
//
//  Created by 大大东 on 2019/3/12.
//  Copyright © 2019 Gaoxin. All rights reserved.
//

#import "NSUserDefaults+AvoidCrash.h"
#import "AvoidCrash.h"

@implementation NSUserDefaults (AvoidCrash)
+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [AvoidCrash exchangeInstanceMethod:[NSUserDefaults class]
                                method1Sel:@selector(setObject:forKey:)
                                method2Sel:@selector(stt_setObject:forKey:)];
    });
}

- (void)stt_setObject:(id)value forKey:(NSString *)defaultName {
    @try {
        
        [self stt_setObject:value forKey:defaultName];
        
    } @catch (NSException *exception) {

#ifdef DEBUG
        @throw exception;
#endif
    }
}

@end
