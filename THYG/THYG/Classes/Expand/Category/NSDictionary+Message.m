//
//  NSDictionary+Message.m
//  THYG
//
//  Created by C on 2019/8/27.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "NSDictionary+Message.h"

@implementation NSDictionary (Message)

- (NSString *)message {
    return [self objectForKey:@"message"];
}

@end
