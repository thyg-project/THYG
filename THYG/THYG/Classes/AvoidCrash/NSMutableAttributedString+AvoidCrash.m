//
//  NSMutableAttributedString+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/15.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableAttributedString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableAttributedString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class NSConcreteMutableAttributedString = NSClassFromString(@"NSConcreteMutableAttributedString");
        
        //initWithString:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString
                                method1Sel:@selector(initWithString:)
                                method2Sel:@selector(avoidCrashInitWithString:)];
        
        //initWithString:attributes:
        [AvoidCrash exchangeInstanceMethod:NSConcreteMutableAttributedString
                                method1Sel:@selector(initWithString:attributes:)
                                method2Sel:@selector(avoidCrashInitWithString:attributes:)];
    });
}

//=================================================================
//                          initWithString:
//=================================================================
#pragma mark - initWithString:


- (instancetype)avoidCrashInitWithString:(NSString *)str {
    if (!str) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to initial NSMutableAttributedString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashInitWithString:str];
}


//=================================================================
//                     initWithString:attributes:
//=================================================================
#pragma mark - initWithString:attributes:


- (instancetype)avoidCrashInitWithString:(NSString *)str attributes:(NSDictionary<NSString *,id> *)attrs {
    if (!str) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to initial NSMutableAttributedString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashInitWithString:str attributes:attrs];
}


@end
