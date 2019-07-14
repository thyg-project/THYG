//
//  NSArray+AvoidCrash.m
//  AvoidCrash
//
//  Created by mac on 16/9/21.
//  Copyright © 2016年 chenfanfang. All rights reserved.
//

#import "NSArray+AvoidCrash.h"

#import "AvoidCrash.h"

@implementation NSArray (AvoidCrash)


+ (void)avoidCrashExchangeMethod {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //=================
        //   class method
        //=================
        
        //instance array method exchange
        [AvoidCrash exchangeClassMethod:[self class]
                             method1Sel:@selector(arrayWithObjects:count:)
                             method2Sel:@selector(AvoidCrashArrayWithObjects:count:)];
        
        //====================
        //   instance method
        //====================
        Class __NSArray = NSClassFromString(@"NSArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        //arrayByAddingObject:
        [AvoidCrash exchangeInstanceMethod:__NSArray
                                method1Sel:@selector(arrayByAddingObject:)
                                method2Sel:@selector(__NSArrayAvoidCrashArrayByAddingObject:)];
        [AvoidCrash exchangeInstanceMethod:__NSArrayI
                                method1Sel:@selector(arrayByAddingObject:)
                                method2Sel:@selector(__NSArrayIAvoidCrashArrayByAddingObject:)];
        
        //objectsAtIndexes:
        [AvoidCrash exchangeInstanceMethod:__NSArray
                                method1Sel:@selector(objectsAtIndexes:)
                                method2Sel:@selector(avoidCrashObjectsAtIndexes:)];
        
        //objectAtIndexedSubscript:
        [AvoidCrash exchangeInstanceMethod:__NSArrayI
                                method1Sel:@selector(objectAtIndexedSubscript:)
                                method2Sel:@selector(avoidCrashObjectAtIndexedSubscript:)];
        
        //objectAtIndex:
        [AvoidCrash exchangeInstanceMethod:__NSArrayI
                                method1Sel:@selector(objectAtIndex:)
                                method2Sel:@selector(__NSArrayIAvoidCrashObjectAtIndex:)];
        
        [AvoidCrash exchangeInstanceMethod:__NSSingleObjectArrayI
                                method1Sel:@selector(objectAtIndex:)
                                method2Sel:@selector(__NSSingleObjectArrayIAvoidCrashObjectAtIndex:)];
        
        [AvoidCrash exchangeInstanceMethod:__NSArray0
                                method1Sel:@selector(objectAtIndex:)
                                method2Sel:@selector(__NSArray0AvoidCrashObjectAtIndex:)];
        
        //getObjects:range:
        [AvoidCrash exchangeInstanceMethod:__NSArray
                                method1Sel:@selector(getObjects:range:)
                                method2Sel:@selector(NSArrayAvoidCrashGetObjects:range:)];
        
        [AvoidCrash exchangeInstanceMethod:__NSSingleObjectArrayI
                                method1Sel:@selector(getObjects:range:)
                                method2Sel:@selector(__NSSingleObjectArrayIAvoidCrashGetObjects:range:)];
        
        [AvoidCrash exchangeInstanceMethod:__NSArrayI
                                method1Sel:@selector(getObjects:range:)
                                method2Sel:@selector(__NSArrayIAvoidCrashGetObjects:range:)];
        
        //subarrayWithRange:
        [AvoidCrash exchangeInstanceMethod:__NSArray
                                method1Sel:@selector(subarrayWithRange:)
                                method2Sel:@selector(avoidCrashSubarrayWithRange:)];
    });
}


//=================================================================
//                        instance array
//=================================================================
#pragma mark - instance array

+ (instancetype)AvoidCrashArrayWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)cnt {
    
    id instance = nil;
    
    @try {
        instance = [self AvoidCrashArrayWithObjects:objects count:cnt];
    }
    @catch (NSException *exception) {
        
        NSString *defaultToDo = @"This framework default is to remove nil object and instance a array.";
        [AvoidCrash noteErrorWithException:exception defaultToDo:defaultToDo];
        
        //以下是对错误数据的处理，把为nil的数据去掉,然后初始化数组
        NSInteger newObjsIndex = 0;
        id  _Nonnull __unsafe_unretained newObjects[cnt];
        
        for (int i = 0; i < cnt; i++) {
            if (objects[i] != nil) {
                newObjects[newObjsIndex] = objects[i];
                newObjsIndex++;
            }
        }
        instance = [self AvoidCrashArrayWithObjects:newObjects count:newObjsIndex];
    }
    @finally {
        return instance;
    }
}

//=================================================================
//                     arrayByAddingObject:
//=================================================================
#pragma mark - arrayByAddingObject:
- (NSArray *)__NSArrayAvoidCrashArrayByAddingObject:(id)anObject {
    if (!anObject) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to add nil object to NSArray"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self __NSArrayAvoidCrashArrayByAddingObject:anObject];
}

- (NSArray *)__NSArrayIAvoidCrashArrayByAddingObject:(id)anObject {
    if (!anObject) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSInvalidArgumentException
                                                                   reason:@"attempt to add nil object to NSArray"
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return self;
    }
    return [self __NSArrayIAvoidCrashArrayByAddingObject:anObject];
}


//=================================================================
//                     objectAtIndexedSubscript:
//=================================================================
#pragma mark - objectAtIndexedSubscript:
- (id)avoidCrashObjectAtIndexedSubscript:(NSUInteger)index {
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
//                       objectsAtIndexes:
//=================================================================
#pragma mark - objectsAtIndexes:

- (NSArray *)avoidCrashObjectsAtIndexes:(NSIndexSet *)indexes {
    // 这里 indexes cout 为0时， lastIndex 返回的是 NSNotFound ，因此不能直接比大小
    if (!indexes || (indexes.count > 0 && indexes.lastIndex + 1 > self.count)) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSArray", indexes.lastIndex]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashObjectsAtIndexes:indexes];
}


//=================================================================
//                         objectAtIndex:
//=================================================================
#pragma mark - objectAtIndex:

//__NSArrayI  objectAtIndex:
- (id)__NSArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self __NSArrayIAvoidCrashObjectAtIndex:index];
}



//__NSSingleObjectArrayI objectAtIndex:
- (id)__NSSingleObjectArrayIAvoidCrashObjectAtIndex:(NSUInteger)index {
//    if (index + 1 > self.count) {
        // index 可能传进来的是负数，但自动转成NSUInteger会变得很大， 所以这面不需要判断 <0 ,只判断不向上越界就可以了
    if (!(index < self.count)) {

        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self __NSSingleObjectArrayIAvoidCrashObjectAtIndex:index];
}

//__NSArray0 objectAtIndex:
- (id)__NSArray0AvoidCrashObjectAtIndex:(NSUInteger)index {
    if (!(index < self.count)) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"index:%lu beyond bounds for NSArray", index]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self __NSArray0AvoidCrashObjectAtIndex:index];
}


//=================================================================
//                           getObjects:range:
//=================================================================
#pragma mark - getObjects:range:

//NSArray getObjects:range:
- (void)NSArrayAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location + range.length > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSArray", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self NSArrayAvoidCrashGetObjects:objects range:range];
}


//__NSSingleObjectArrayI  getObjects:range:
- (void)__NSSingleObjectArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location + range.length > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSArray", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self __NSSingleObjectArrayIAvoidCrashGetObjects:objects range:range];
}


//__NSArrayI  getObjects:range:
- (void)__NSArrayIAvoidCrashGetObjects:(__unsafe_unretained id  _Nonnull *)objects range:(NSRange)range {
    if (range.location + range.length > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSArray", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultIgnore];
        return;
    }
    [self __NSArrayIAvoidCrashGetObjects:objects range:range];
}

//=================================================================
//                           subarrayWithRange:
//=================================================================
#pragma mark - subarrayWithRange:

//NSArray subarrayWithRange:
- (NSArray *)avoidCrashSubarrayWithRange:(NSRange)range {
    if (range.location + range.length > self.count) {
        [AvoidCrash noteErrorWithException:[NSException exceptionWithName:NSRangeException
                                                                   reason:[NSString stringWithFormat:@"range:%@ beyond bounds for NSArray", NSStringFromRange(range)]
                                                                 userInfo:nil]
                               defaultToDo:AvoidCrashDefaultReturnNil];
        return nil;
    }
    return [self avoidCrashSubarrayWithRange:range];
}

@end
