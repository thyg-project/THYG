//
//  NSAttributedString+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSAttributedString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSAttributedString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteAttributedString = NSClassFromString(@"NSConcreteAttributedString");
        
        //initWithString:
        [AvoidCrash exchangeInstanceMethod:NSConcreteAttributedString
                                method1Sel:@selector(initWithString:)
                                method2Sel:@selector(avoidCrashInitWithString:)];
        
        //initWithAttributedString:
        [AvoidCrash exchangeInstanceMethod:NSConcreteAttributedString
                                method1Sel:@selector(initWithAttributedString:)
                                method2Sel:@selector(avoidCrashInitWithAttributedString:)];
        
        //initWithString:attributes:
        [AvoidCrash exchangeInstanceMethod:NSConcreteAttributedString
                                method1Sel:@selector(initWithString:attributes:)
                                method2Sel:@selector(avoidCrashInitWithString:attributes:)];
    });

}

//=================================================================
//                           initWithString:
//=================================================================
#pragma mark - initWithString:

- (instancetype)avoidCrashInitWithString:(NSString *)str {
    if (!str) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to initial NSAttributedString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashInitWithString:str];
}


//=================================================================
//                          initWithAttributedString
//=================================================================
#pragma mark - initWithAttributedString

- (instancetype)avoidCrashInitWithAttributedString:(NSAttributedString *)attrStr {
    if (!attrStr) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to initial NSAttributedString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashInitWithAttributedString:attrStr];
}


//=================================================================
//                      initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:

- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    if (!str) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to initial NSAttributedString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashInitWithString:str attributes:attrs];
}

@end
