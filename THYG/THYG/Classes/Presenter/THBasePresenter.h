//
//  THBasePresenter.h
//  THYG
//
//  Created by C on 2019/7/10.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THBaseProtocol.h"

@interface THBasePresenter : NSObject

@property (nonatomic, weak, readonly) id <THBaseProtocol> delegate;

- (instancetype)initPresenterWithProtocol:(id <THBaseProtocol>)protocol;

- (void)getTask:(NSURLSessionTask *)task;

- (void)performToSelector:(SEL)aSelecter params:(id)param;

@end


