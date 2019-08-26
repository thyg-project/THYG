//
//  YGUtils.h
//  YaloGame
//
//  Created by C on 2018/11/17.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



typedef struct _YGInfo_t {
    /**
     合法有效字符串
     */
    BOOL (*validString)(NSString *string);
    /**
     合法有效数组
     */
    BOOL (*validArray)(NSArray *array);//sssssss
    /**
     合法有效字典
     */
    BOOL (*validDictionary)(NSDictionary *dictionary);
    /**
     是否是刘海屏
     */
    BOOL (*isBangScreen)(void);
    /**
     是否是有效的url
     */
    NSURL * (*URLFromString)(NSString *urlStr);
    /**
     获取IDFV
     */
    NSString * (*IDFV)(void);
    /**
     获取app版本
     */
    NSString * (*appVersion)(void);
    /**
     获取手机版本
     */
    NSString * (*deviceVersion)(void);
    /**
     获取手机模型
     */
    NSString * (*deviceModel)(void);
    /**
     获取安全区域
     */
    UIEdgeInsets (*applicationSafeAreaInsets)(void);
    /**
     获取状态栏高度
     */
    CGFloat (*statesBarHeight)(void);
    
} YGInfo_t;
OBJC_EXTERN YGInfo_t YGInfo;

