//
//  AppDelegate.m
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 Victory. All rights reserved.
//

#import "AppDelegate.h"
#import "THTabBarController.h"
#import "THGuideViewTool.h"
#import "THPay.h"
#import <WXApi.h>
#import <AlipaySDK/AlipaySDK.h>
#import <Bugly/Bugly.h>
#import "THShareTool.h"
#import "IQKeyboardManager.h"
#import "AvoidCrash.h"

@interface AppDelegate ()

@end

static NSString *const kApiSecret = @"3176b5f31b3e4c693b25635b8b3b69fe";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    UIViewController *rootVc = [THGuideViewTool chooseRootViewController];
    self.window.rootViewController = rootVc;
    [self.window makeKeyAndVisible];
    [AvoidCrash becomeEffective];
    [WXApi registerApp:@"wx1792977a45662b26"];
    
    [Bugly startWithAppId:@"3739643c93"];
	
	[THShareTool openLog:YES];
	[THShareTool initUmSocialShare];
	
	return YES;
    
}

- (void)registerIQKeyboard {
    IQKeyboardManager *m = [IQKeyboardManager sharedManager];
    m.enable = NO;
    m.shouldResignOnTouchOutside = NO;
    m.shouldToolbarUsesTextFieldTintColor = NO;
    m.enableAutoToolbar = NO;
}


// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //微信支付回调
    if ([url.host isEqual:@"pay"]) {
        return [WXApi handleOpenURL:url delegate:(id)[THPay class]];
    }
    //支付宝支付
    else if ([url.host isEqualToString:@"safepay"]){
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
        return YES;
    }
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
