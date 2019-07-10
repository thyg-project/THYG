//
//  THBaseProtocol.h
//  THYG
//
//  Created by C on 2019/7/10.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol THBaseProtocol <NSObject>

@optional

- (void)getTask:(NSURLSessionTask *)task;

- (void)getDataSuccess:(id)success extra:(NSDictionary *)extra;

- (void)getDataFailed:(NSDictionary *)errorMessage extra:(NSDictionary *)extra;

@end


