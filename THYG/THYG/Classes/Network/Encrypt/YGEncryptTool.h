//
//  YGEncryptTool.h
//  YaloGame
//
//  Created by C on 2018/12/10.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YGEncryptTool : NSObject

+ (NSString *)rsaEncrypt:(NSString *)source;

@end

NS_ASSUME_NONNULL_END
