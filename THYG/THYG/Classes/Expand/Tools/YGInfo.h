//
//  YGUtils.h
//  YaloGame
//
//  Created by C on 2018/11/17.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct _YGInfo_t {
    
    BOOL (*validString)(NSString *string);
    
   
    BOOL (*validArray)(NSArray *array);
    
    
    BOOL (*validDictionary)(NSDictionary *dictionary);
    
    BOOL (*isBangScreen)(void);
    
    
    NSURL * (*URLFromString)(NSString *urlStr);
    
    NSString * (*IDFV)(void);
    
    NSString * (*appVersion)(void);
    
    NSString * (*deviceVersion)(void);
    
    NSString * (*deviceModel)(void);
    
} YGInfo_t;
OBJC_EXTERN YGInfo_t YGInfo;

