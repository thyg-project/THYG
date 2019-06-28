//
//  YGNetWorkTools.h
//  test
//
//  Created by C on 2018/11/22.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"



typedef void(^SuccessBlock)(id responseObject);

typedef void(^FailedBlock)(NSDictionary *errorInfo);

typedef void(^SessionBlock)(AFHTTPSessionManager *manager);

@interface YGNetWorkTools : NSObject

@property (nonatomic, assign) NSTimeInterval timeoutInterval;



+ (instancetype)sharedTools;

- (void)get:(NSString *)url
 parameters:(NSDictionary *)parameters
    success:(SuccessBlock)success
     failed:(FailedBlock)faild;

- (void)post:(NSString *)url
  parameters:(NSDictionary *)parameters
     success:(SuccessBlock)success
      failed:(FailedBlock)failed;

- (void)get:(NSString *)url
sessionConfig:(SessionBlock)block
 parameters:(NSDictionary *)parameters
    success:(SuccessBlock)success
     failed:(FailedBlock)faild;

- (void)post:(NSString *)url
sessionConfig:(SessionBlock)block
  parameters:(NSDictionary *)parameters
     success:(SuccessBlock)success
      failed:(FailedBlock)failed;

- (void)upload:(NSString *)url
      fileName:(NSString *)fileName
    parameters:(NSDictionary *)parameters
          data:(NSData *)data
       success:(SuccessBlock)success
        failed:(FailedBlock)failed;

- (void)upload:(NSString *)url
      fileName:(NSString *)fileName 
 sessionConfig:(SessionBlock)block
    parameters:(NSDictionary *)parameters
          data:(NSData *)data
       success:(SuccessBlock)success
        failed:(FailedBlock)failed;

- (void)put:(NSString *)url
sessionConfig:(SessionBlock)block
 parameters:(NSDictionary *)parameters
    success:(SuccessBlock)success
     failed:(FailedBlock)failed;

- (void)put:(NSString *)url
 parameters:(NSDictionary *)parameters
    success:(SuccessBlock)success
     failed:(FailedBlock)failed;

- (void)delete:(NSString *)url
    parameters:(NSDictionary *)parameters
       success:(SuccessBlock)success
        failed:(FailedBlock)failed;

- (void)delete:(NSString *)url
 sessionConfig:(SessionBlock)block
    parameters:(NSDictionary *)parameters
       success:(SuccessBlock)success
        failed:(FailedBlock)failed;

@end

