//
//  NSMutableArray+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSMutableArray+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSMutableArray (AvoidCrash)

+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class arrayMClass = NSClassFromString(@"__NSArrayM");
        
        //objectAtIndex:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(objectAtIndex:)
                                method2Sel:@selector(avoidCrashObjectAtIndex:)];
        
        //objectAtIndexedSubscript:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(objectAtIndexedSubscript:)
                                method2Sel:@selector(avoidCrashObjectAtIndexedSubscript:)];
        
        
        //addObject:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(addObject:)
                                method2Sel:@selector(avoidCrashAddObject:)];
        
        //setObject:atIndexedSubscript:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(setObject:atIndexedSubscript:)
                                method2Sel:@selector(avoidCrashSetObject:atIndexedSubscript:)];
        
        //removeObjectAtIndex:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(removeObjectAtIndex:)
                                method2Sel:@selector(avoidCrashRemoveObjectAtIndex:)];
        
        //insertObject:atIndex:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(insertObject:atIndex:)
                                method2Sel:@selector(avoidCrashInsertObject:atIndex:)];
        
        //getObjects:range:
        [AvoidCrash exchangeInstanceMethod:arrayMClass
                                method1Sel:@selector(getObjects:range:)
                                method2Sel:@selector(avoidCrashGetObjects:range:)];
    });
}

//=================================================================
//                    addObject:
//=================================================================
#pragma mark - addObject:

- (void)avoidCrashAddObject:(id)anObject {
    if (!anObject) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to add nil object to NSMutableArray"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashAddObject:anObject];
}


//=================================================================
//                    array set object at index
//=================================================================
#pragma mark - get object from array

- (void)avoidCrashSetObject:(id)obj atIndexedSubscript:(NSUInteger)idx {
    if (!obj) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to set nil object to NSMutableArray"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    // 这里 idx 可以等于 count
    if (idx > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSMutableArray", idx]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashSetObject:obj atIndexedSubscript:idx];
}


//=================================================================
//                    removeObjectAtIndex:
//=================================================================
#pragma mark - removeObjectAtIndex:

- (void)avoidCrashRemoveObjectAtIndex:(NSUInteger)index {
    if (!(index < self.count)) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSMutableArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashRemoveObjectAtIndex:index];
}


//=================================================================
//                    insertObject:atIndex:
//=================================================================
#pragma mark - set方法
- (void)avoidCrashInsertObject:(id)anObject atIndex:(NSUInteger)index {
    if (!anObject) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to insert nil object to NSMutableArray"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    if (index > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSMutableArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashInsertObject:anObject atIndex:index];
}


//=================================================================
//                           objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

- (id)avoidCrashObjectAtIndex:(NSUInteger)index {
//    if (index + 1 > self.count) {
    // index 可能传进来的是负数，但自动转成NSUInteger会变得很大， 所以这面不需要判断 <0 ,只判断不向上越界就可以了
    if (!(index < self.count)) {
        
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSMutableArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashObjectAtIndex:index];
}

//=================================================================
//                           ObjectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndex:

- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)index {
    //    if (index + 1 > self.count) {
    // index 可能传进来的是负数，但自动转成NSUInteger会变得很大， 所以这面不需要判断 <0 ,只判断不向上越界就可以了
    if (!(index < self.count)) {
        
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSMutableArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashObjectAtIndexedSubscript:index];
}



//=================================================================
//                         getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

- (void)avoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location + range.length > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSMutableArray", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self avoidCrashGetObjects:objects range:range];
}

@end
