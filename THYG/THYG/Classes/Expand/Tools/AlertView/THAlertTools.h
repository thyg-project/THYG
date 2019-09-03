//
//  THAlertTools.h
//  THYG
//
//  Created by C on 2019/7/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface THAlertTools : NSObject

+ (void)alertTitle:(NSString *)title
           message:(NSString *)message
           confirm:(NSString *)confirm
         container:(UIViewController *)container
    confirmHandler:(void (^)(void))confirmHandler
            cancel:(NSString *)cancel
     cancelHandler:(void(^)(void))cancelHandler;

@end

