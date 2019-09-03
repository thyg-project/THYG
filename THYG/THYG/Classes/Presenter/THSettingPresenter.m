//
//  THSettingPresenter.m
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THSettingPresenter.h"
#import <WebKit/WebKit.h>

@implementation THSettingPresenter

- (void)logout {
    NSURLSessionTask *task = [YGNetworkCommon logoutSuccess:^(id responseObject) {
        [self performToSelector:@selector(logoutSuccess) params:nil];
    } failed:^(NSDictionary *errorInfo) {
        [self performToSelector:@selector(logoutSuccess) params:nil];
    }];
    [self getTask:task];
}

- (void)clearCache {
    NSString *filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:filePath];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [filePath stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    
    [[YYImageCache sharedCache].diskCache removeAllObjects];
    
    // 清理wk缓存
    if (@available(iOS 9.0, *)) {
        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:[WKWebsiteDataStore allWebsiteDataTypes] modifiedSince:[NSDate dateWithTimeIntervalSince1970:0] completionHandler:^{
            
        }];
    }
    // 清理url cache （get/webview）
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performToSelector:@selector(clearCacheSuccess) params:nil];
    });
}


@end
