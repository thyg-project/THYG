//
//  THAlertTools.m
//  THYG
//
//  Created by C on 2019/7/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THAlertTools.h"

@implementation THAlertTools

+ (void)alertTitle:(NSString *)title
           message:(NSString *)message
           confirm:(NSString *)confirm
         container:(UIViewController *)container
    confirmHandler:(void (^)(void))confirmHandler
            cancel:(NSString *)cancel
     cancelHandler:(void(^)(void))cancelHandler {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (YGInfo.validString(confirm)) {
        UIAlertAction *confirmA = [UIAlertAction actionWithTitle:confirm style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmHandler) {
                confirmHandler();
            }
        }];
        [controller addAction:confirmA];
    }
    if (YGInfo.validString(cancel)) {
        UIAlertAction *cancelA = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelHandler) {
                cancelHandler();
            }
        }];
        [controller addAction:cancelA];
    }
    [controller presentViewController:controller animated:YES completion:nil];
}


@end
