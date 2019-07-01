//
//  YGNetWorkTools.h
//  test
//
//  Created by C on 2018/11/22.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, NetworkState) {
    NetworkState_Unknown    = 0 ,
    NetworkState_NotReachable   ,
    NetworkState_WWAN           ,
    NetworkState_WIFI           
};

typedef void(^SuccessBlock)(id responseObject);

typedef void(^FailedBlock)(NSDictionary *errorInfo);

typedef void(^SessionBlock)(AFHTTPSessionManager *manager);

@interface YGNetWorkTools : NSObject

@property (nonatomic, assign) NSTimeInterval timeoutInterval;



+ (instancetype)sharedTools;

- (NSURLSessionTask *)get:(NSString *)url
               parameters:(NSDictionary *)parameters
                  success:(SuccessBlock)success
                   failed:(FailedBlock)faild;

- (NSURLSessionTask *)post:(NSString *)url
                parameters:(NSDictionary *)parameters
                   success:(SuccessBlock)success
                    failed:(FailedBlock)failed;

- (NSURLSessionTask *)get:(NSString *)url
            sessionConfig:(SessionBlock)block
               parameters:(NSDictionary *)parameters
                  success:(SuccessBlock)success
                   failed:(FailedBlock)faild;

- (NSURLSessionTask *)post:(NSString *)url
             sessionConfig:(SessionBlock)block
                parameters:(NSDictionary *)parameters
                   success:(SuccessBlock)success
                    failed:(FailedBlock)failed;

- (NSURLSessionTask *)upload:(NSString *)url
                    fileName:(NSString *)fileName
                  parameters:(NSDictionary *)parameters
                        data:(NSData *)data
                     success:(SuccessBlock)success
                      failed:(FailedBlock)failed;

- (NSURLSessionTask *)upload:(NSString *)url
                    fileName:(NSString *)fileName
               sessionConfig:(SessionBlock)block
                  parameters:(NSDictionary *)parameters
                        data:(NSData *)data
                     success:(SuccessBlock)success
                      failed:(FailedBlock)failed;

- (NSURLSessionTask *)put:(NSString *)url
            sessionConfig:(SessionBlock)block
               parameters:(NSDictionary *)parameters
                  success:(SuccessBlock)success
                   failed:(FailedBlock)failed;

- (NSURLSessionTask *)put:(NSString *)url
               parameters:(NSDictionary *)parameters
                  success:(SuccessBlock)success
                   failed:(FailedBlock)failed;

- (NSURLSessionTask *)delete:(NSString *)url
                  parameters:(NSDictionary *)parameters
                     success:(SuccessBlock)success
                      failed:(FailedBlock)failed;

- (NSURLSessionTask *)delete:(NSString *)url
               sessionConfig:(SessionBlock)block
                  parameters:(NSDictionary *)parameters
                     success:(SuccessBlock)success
                      failed:(FailedBlock)failed;

+ (NetworkState)networkState;

+ (void)observerNetworkState:(void (^)(NetworkState state))changleBlock;

+ (void)stopObserver;

+ (void)cancelTask:(NSURLSessionTask *)task;

+ (void)cancelTasks:(NSArray <NSURLSessionTask *> *)tasks;

@end

