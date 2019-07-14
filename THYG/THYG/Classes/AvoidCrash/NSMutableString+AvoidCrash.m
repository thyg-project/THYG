//
//  NSMutableString+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/6.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class stringClass = NSClassFromString(@"__NSCFString");
        
        //setString:
        [AvoidCrash exchangeInstanceMethod:stringClass
                                method1Sel:@selector(setString:)
                                method2Sel:@selector(avoidCrashSetString:)];
        
        //appendString:
        [AvoidCrash exchangeInstanceMethod:stringClass
                                method1Sel:@selector(appendString:)
                                method2Sel:@selector(avoidCrashAppendString:)];
        
        //replaceCharactersInRange:
        [AvoidCrash exchangeInstanceMethod:stringClass
                                method1Sel:@selector(replaceCharactersInRange:withString:)
                                method2Sel:@selector(avoidCrashReplaceCharactersInRange:withString:)];
        
        //insertString:atIndex:
        [AvoidCrash exchangeInstanceMethod:stringClass
                                method1Sel:@selector(insertString:atIndex:)
                                method2Sel:@selector(avoidCrashInsertString:atIndex:)];
        
        //deleteCharactersInRange:
        [AvoidCrash exchangeInstanceMethod:stringClass
                                method1Sel:@selector(deleteCharactersInRange:)
                                method2Sel:@selector(avoidCrashDeleteCharactersInRange:)];
    });
}

//=================================================================
//                     setString:
//=================================================================
#pragma mark - setString:

- (void)avoidCrashSetString:(NSString *)aString {
    if (!aString) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to set string with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashSetString:aString];
}

//=================================================================
//                     appendString:
//=================================================================
#pragma mark - appendString:

- (void)avoidCrashAppendString:(NSString *)aString {
    if (!aString) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to append string with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashAppendString:aString];
}

//=================================================================
//                     replaceCharactersInRange:
//=================================================================
#pragma mark - replaceCharactersInRange:

- (void)avoidCrashReplaceCharactersInRange:(NSRange)range withString:(NSString *)aString {
    if (!aString) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace string with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    if (range.location + range.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSMutableString", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashReplaceCharactersInRange:range withString:aString];
}

//=================================================================
//                     insertString:atIndex:
//=================================================================
#pragma mark - insertString:atIndex:

- (void)avoidCrashInsertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (!aString) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to insert string with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    if (loc > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds:%@ for NSString", loc, @(self.length)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashInsertString:aString atIndex:loc];
}

//=================================================================
//                   deleteCharactersInRange:
//=================================================================
#pragma mark - deleteCharactersInRange:

- (void)avoidCrashDeleteCharactersInRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSMutableString", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashDeleteCharactersInRange:range];
}

@end
