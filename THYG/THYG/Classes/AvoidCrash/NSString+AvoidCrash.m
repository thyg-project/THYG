//
//  NSString+AvoidCrash.m
//  AvoidCrashDemo
//
//  Created by mac on 16/10/5.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSString+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSString (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class constStrClass = NSClassFromString(@"__NSCFConstantString");
        Class cfStrClass = NSClassFromString(@"__NSCFString");
        Class initStrClass = NSClassFromString(@"NSPlaceholderString");
        
        //initWithString:
        [AvoidCrash exchangeInstanceMethod:initStrClass
                                method1Sel:@selector(initWithString:)
                                method2Sel:@selector(avoidCrashInitWithString:)];
        
        //stringByAppendingString:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(stringByAppendingString:)
                                method2Sel:@selector(avoidCrashStringByAppendingString:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(stringByAppendingString:)
                                method2Sel:@selector(CFAvoidCrashStringByAppendingString:)];
        
        //characterAtIndex:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(characterAtIndex:)
                                method2Sel:@selector(avoidCrashCharacterAtIndex:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(characterAtIndex:)
                                method2Sel:@selector(CFAvoidCrashCharacterAtIndex:)];
        
        //substringFromIndex:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(substringFromIndex:)
                                method2Sel:@selector(avoidCrashSubstringFromIndex:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(substringFromIndex:)
                                method2Sel:@selector(CFAvoidCrashSubstringFromIndex:)];
        
        //substringToIndex:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(substringToIndex:)
                                method2Sel:@selector(avoidCrashSubstringToIndex:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(substringToIndex:)
                                method2Sel:@selector(CFAvoidCrashSubstringToIndex:)];
        
        //substringWithRange:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(substringWithRange:)
                                method2Sel:@selector(avoidCrashSubstringWithRange:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(substringWithRange:)
                                method2Sel:@selector(CFAvoidCrashSubstringWithRange:)];
        
        //stringByReplacingOccurrencesOfString:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:)
                                method2Sel:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:)
                                method2Sel:@selector(CFAvoidCrashStringByReplacingOccurrencesOfString:withString:)];
        
        //stringByReplacingOccurrencesOfString:withString:options:range:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                                method2Sel:@selector(avoidCrashStringByReplacingOccurrencesOfString:withString:options:range:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(stringByReplacingOccurrencesOfString:withString:options:range:)
                                method2Sel:@selector(CFAvoidCrashStringByReplacingOccurrencesOfString:withString:options:range:)];
        
        //stringByReplacingCharactersInRange:withString:
        [AvoidCrash exchangeInstanceMethod:constStrClass
                                method1Sel:@selector(stringByReplacingCharactersInRange:withString:)
                                method2Sel:@selector(avoidCrashStringByReplacingCharactersInRange:withString:)];
        [AvoidCrash exchangeInstanceMethod:cfStrClass
                                method1Sel:@selector(stringByReplacingCharactersInRange:withString:)
                                method2Sel:@selector(CFAvoidCrashStringByReplacingCharactersInRange:withString:)];
    });
    
}

//=================================================================
//                           initWithString:
//=================================================================
#pragma mark - initWithString:

- (NSString *)avoidCrashInitWithString:(NSString *)string {
    if (!string) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to initial NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashInitWithString:string];
}

//=================================================================
//                           stringByAppendingString:
//=================================================================
#pragma mark - stringByAppendingString:

- (NSString *)avoidCrashStringByAppendingString:(NSString *)aString {
    if (!aString) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to append NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self avoidCrashStringByAppendingString:aString];
}

- (NSString *)CFAvoidCrashStringByAppendingString:(NSString *)aString {
    if (!aString) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to append NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self CFAvoidCrashStringByAppendingString:aString];
}

//=================================================================
//                           characterAtIndex:
//=================================================================
#pragma mark - characterAtIndex:

- (unichar)avoidCrashCharacterAtIndex:(NSUInteger)index {
    if (index + 1 > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:@""
                                                                 userInfo:nil]
                               defaultToDo:@"This framework default is to return a without assign unichar."];
        return 0;
    }
    return [self avoidCrashCharacterAtIndex:index];
}

- (unichar)CFAvoidCrashCharacterAtIndex:(NSUInteger)index {
    if (index + 1 > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:@""
                                                                 userInfo:nil]
                               defaultToDo:@"This framework default is to return a without assign unichar."];
        return 0;
    }
    return [self CFAvoidCrashCharacterAtIndex:index];
}

//=================================================================
//                           substringFromIndex:
//=================================================================
#pragma mark - substringFromIndex:

- (NSString *)avoidCrashSubstringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSString", from]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashSubstringFromIndex:from];
}

- (NSString *)CFAvoidCrashSubstringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSString", from]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self CFAvoidCrashSubstringFromIndex:from];
}

//=================================================================
//                           substringToIndex
//=================================================================
#pragma mark - substringToIndex

- (NSString *)avoidCrashSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSString", to]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashSubstringToIndex:to];
}

- (NSString *)CFAvoidCrashSubstringToIndex:(NSUInteger)to {
    if (to > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSString", to]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self CFAvoidCrashSubstringToIndex:to];
}

//=================================================================
//                           substringWithRange:
//=================================================================
#pragma mark - substringWithRange:

- (NSString *)avoidCrashSubstringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSString", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashSubstringWithRange:range];
}

- (NSString *)CFAvoidCrashSubstringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSString", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self CFAvoidCrashSubstringWithRange:range];
}

//=================================================================
//                stringByReplacingOccurrencesOfString:
//=================================================================
#pragma mark - stringByReplacingOccurrencesOfString:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    if (!target || !replacement) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement];
}

- (NSString *)CFAvoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement {
    if (!target || !replacement) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self CFAvoidCrashStringByReplacingOccurrencesOfString:target withString:replacement];
}

//=================================================================
//  stringByReplacingOccurrencesOfString:withString:options:range:
//=================================================================
#pragma mark - stringByReplacingOccurrencesOfString:withString:options:range:

- (NSString *)avoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    if (!target || !replacement) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    if (searchRange.location + searchRange.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSString", NSStringFromRange(searchRange)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self avoidCrashStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}

- (NSString *)CFAvoidCrashStringByReplacingOccurrencesOfString:(NSString *)target withString:(NSString *)replacement options:(NSStringCompareOptions)options range:(NSRange)searchRange {
    if (!target || !replacement) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    if (searchRange.location + searchRange.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSString", NSStringFromRange(searchRange)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self CFAvoidCrashStringByReplacingOccurrencesOfString:target withString:replacement options:options range:searchRange];
}

//=================================================================
//       stringByReplacingCharactersInRange:withString:
//=================================================================
#pragma mark - stringByReplacingCharactersInRange:withString:

- (NSString *)avoidCrashStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (!replacement) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    if (range.location + range.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSString", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self avoidCrashStringByReplacingCharactersInRange:range withString:replacement];
}

- (NSString *)CFAvoidCrashStringByReplacingCharactersInRange:(NSRange)range withString:(NSString *)replacement {
    if (!replacement) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to replace NSString with nil object"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    if (range.location + range.length > self.length) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSString", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self CFAvoidCrashStringByReplacingCharactersInRange:range withString:replacement];
}

@end
