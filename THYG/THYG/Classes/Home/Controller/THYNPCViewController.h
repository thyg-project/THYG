//
//  THYNPCViewController.h
//  THYG
//
//  Created by C on 2019/11/8.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ViewControllerType) {
    ViewControllerType_YNPC             = 0,//要你品尝
    ViewControllerType_SLYS             = 1,//时令预售
};

@interface THYNPCViewController : THBaseVC

@property (nonatomic, assign) ViewControllerType controllerType;

@end

NS_ASSUME_NONNULL_END
