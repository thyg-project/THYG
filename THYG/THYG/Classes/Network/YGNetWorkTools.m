//
//  YGNetWorkTools.m
//  test
//
//  Created by C on 2018/11/22.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGNetWorkTools.h"
#import "THUserManager.h"

static inline NSSet *acceptableContentTypes() {
    return [NSSet setWithObjects:@"text/html", @"text/json", @"text/plain", @"text/javascript", @"application/json", @"application/javascript", nil];
}

NSString * formatUrl(NSString *sourceUrl) {
    return sourceUrl;
}

@interface YGNetWorkTools()

@property (nonatomic, strong) AFHTTPSessionManager *manager;


@end

@implementation YGNetWorkTools

NetworkState _lastNetworkState;

+ (instancetype)sharedTools {
    static YGNetWorkTools *tools = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tools = [[self alloc] init];
    });
    return tools;
}

- (instancetype)init {
    if (self = [super init]) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _manager.requestSerializer.HTTPShouldUsePipelining = YES;
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 30;
        [_manager.requestSerializer setValue:@"MMApp/1.0.0 NetType/WIFI Language/zh_CN(MM iOS APP/1.0)" forHTTPHeaderField:@"User-Agent"];
        _manager.responseSerializer.acceptableContentTypes = acceptableContentTypes();
    }
    return self;
}

- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    _timeoutInterval = timeoutInterval;
    self.manager.requestSerializer.timeoutInterval = _timeoutInterval;
}

- (NSURLSessionTask *)get:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)faild {
    return [self.manager GET:formatUrl(url) parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponse:responseObject success:success failed:faild];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseError:error failed:faild];
    }];
}

- (NSURLSessionTask *)post:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
   NSURLSessionDataTask *task = [self.manager POST:formatUrl(url) parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponse:responseObject success:success failed:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseError:error failed:failed];
    }];
    return task;
}

- (NSURLSessionTask *)get:(NSString *)url sessionConfig:(SessionBlock)block parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)faild {
    BLOCK(block,self.manager);
    return [self get:url parameters:parameters success:success failed:faild];
}


- (NSURLSessionTask *)post:(NSString *)url sessionConfig:(SessionBlock)block parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
    BLOCK(block,self.manager);
    return [self post:url parameters:parameters success:success failed:failed];
}

- (NSURLSessionTask *)put:(NSString *)url sessionConfig:(SessionBlock)block parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
    BLOCK(block,self.manager);
   return [self put:url parameters:parameters success:success failed:failed];
}

- (NSURLSessionTask *)delete:(NSString *)url sessionConfig:(SessionBlock)block parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
    BLOCK(block,self.manager);
   return [self delete:url parameters:parameters success:success failed:failed];
}

- (NSURLSessionTask *)delete:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *dict = [parameters mutableCopy];
    [dict setValue:@"delete" forKey:@"method"];
    return [self post:url parameters:dict success:success failed:failed];
}

- (NSURLSessionTask *)put:(NSString *)url parameters:(NSDictionary *)parameters success:(SuccessBlock)success failed:(FailedBlock)failed {
    NSMutableDictionary *dict = [parameters mutableCopy];
    [dict setValue:@"put" forKey:@"method"];
   return [self post:url parameters:dict success:success failed:failed];
}

- (NSURLSessionTask *)upload:(NSString *)url fileName:(NSString *)fileName sessionConfig:(SessionBlock)block parameters:(NSDictionary *)parameters data:(NSData *)data success:(SuccessBlock)success failed:(FailedBlock)failed {
    BLOCK(block,self.manager);
   return [self upload:url fileName:fileName parameters:parameters data:data success:success failed:failed];
}

- (NSURLSessionTask *)upload:(NSString *)url fileName:(NSString *)fileName parameters:(NSDictionary *)parameters data:(NSData *)data success:(SuccessBlock)success failed:(FailedBlock)failed {
   return [self.manager POST:formatUrl(url) parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:data name:@"head_pic" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self parseResponse:responseObject success:success failed:failed];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self parseError:error failed:failed];
    }];
}

+ (NetworkState)networkState {
    NetworkState netState = NetworkState_Unknown;
    AFNetworkReachabilityStatus state = [AFNetworkReachabilityManager sharedManager].networkReachabilityStatus;
    switch (state) {
            case AFNetworkReachabilityStatusUnknown:
            netState = NetworkState_Unknown;
            break;
            case AFNetworkReachabilityStatusNotReachable:
            netState = NetworkState_NotReachable;
            break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
            netState = NetworkState_WWAN;
            break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
            netState = NetworkState_WIFI;
            break;
    }
    return netState;
}

+ (void)observerNetworkState:(void (^)(NetworkState state))changleBlock {
    
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
   __block NetworkState currentState = NetworkState_Unknown;
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
                case AFNetworkReachabilityStatusReachableViaWiFi: {
                    currentState = NetworkState_WIFI;
                }

                break;
                case AFNetworkReachabilityStatusReachableViaWWAN: {
                    currentState = NetworkState_WWAN;
                }
                break;
                case AFNetworkReachabilityStatusNotReachable: {
                    currentState = NetworkState_NotReachable;
                }
                break;
                
            default:
                break;
        }
        if (_lastNetworkState != currentState) {
            _lastNetworkState = currentState;
            BLOCK(changleBlock,currentState);
        }
    }];
    [manager startMonitoring];
}

+ (void)stopObserver {
    [[AFNetworkReachabilityManager sharedManager] stopMonitoring];
}

- (void)parseError:(NSError *)error failed:(FailedBlock)faied {
    if (error.code == NSURLErrorTimedOut) {
        BLOCK(faied,@{@"message":@"请检查网络状态..."});
        return;
    }
        id data = error.userInfo[@"com.alamofire.serialization.response.error.data"];
    if (!data || ![data isKindOfClass:[NSData class]]) {
        BLOCK(faied,@{@"message":@"失败"});
        return;
    }
        id oj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments error:nil];
    if ([oj[@"status"] integerValue] == 401) {
//        YGUserInfo.defaultInstance.autoLogin = YES;
//        [YGUserInfo.defaultInstance clearData];
    }
    
    BLOCK(faied,oj);
}

- (void)parseResponse:(id)response success:(SuccessBlock)success failed:(FailedBlock)failed{
    id oj = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:nil];
    if (![oj isKindOfClass:[NSDictionary class]]) {
        BLOCK(failed,@{@"message":@"服务器返回数个格式有误"});
        return;
    }
    if ([[oj objectForKey:@"message"] isEqual:[NSNull null]]) {
        [oj setValue:@"服务端返回错误" forKey:@"message"];
    }
    if ([oj[@"status"] integerValue] == 2001) {
        [[THUserManager sharedInstance] destory];
        BLOCK(failed,oj);
        return;
    }
    if ([((NSDictionary *)oj).allKeys containsObject:@"token"]) {
//        YGUserInfo.defaultInstance.token = oj[@"token"];
    }
    if ([oj[@"status"] integerValue] != 200) {
        BLOCK(failed,oj);
        return;
    }
    
    if ([((NSDictionary *)oj).allKeys containsObject:@"ret_data"]) {
         BLOCK(success,oj[@"ret_data"]);
    } else {
         BLOCK(success,oj);
    }
    
}

+ (void)cancelTask:(NSURLSessionTask *)task {
    if (task.state != NSURLSessionTaskStateCompleted) {
        [task cancel];
    }
}

+ (void)cancelTasks:(NSArray <NSURLSessionTask *> *)tasks {
    [tasks enumerateObjectsUsingBlock:^(NSURLSessionTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self cancelTask:obj];
    }];
}

@end
