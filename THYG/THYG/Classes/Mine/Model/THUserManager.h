//
//  THUserManager.h
//  THYG
//
//  Created by C on 2019/7/17.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THUserInfoModel.h"


@interface THUserManager : NSObject

@property (nonatomic, strong, class, readonly) THUserManager *sharedInstance;

@property (nonatomic, strong) THUserInfoModel *userInfo;



@end

