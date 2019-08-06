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
#import <Bugly/Bugly.h>
#import "THShareTool.h"
#import "IQKeyboardManager.h"
#import "AvoidCrash.h"

@interface AppDelegate () <BuglyDelegate>

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
    [self registerBugly];
	
    [THShareTool configShareSDK];
	
	return YES;
    
}

- (void)registerBugly {
    BOOL develop = NO;
    BuglyConfig *config = [BuglyConfig new];
    config.version = YGInfo.appVersion();
    config.channel = @"AppStore";
    config.delegate = self;
    config.reportLogLevel = BuglyLogLevelInfo;
#ifdef DEBUG
    config.debugMode = YES;
    develop = YES;
#endif
    [Bugly setUserValue:YGInfo.IDFV() forKey:@"IDFV"];
//    [Bugly setUserValue:YGInfo.IDFA() forKey:@"IDFA"];
    [Bugly setUserIdentifier:YGInfo.IDFV()];
    [Bugly startWithAppId:@"3739643c93" developmentDevice:develop config:config];
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
    return [THPay th_application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    
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


- (NSString * BLY_NULLABLE)attachmentForException:(NSException * BLY_NULLABLE)exception {
    return @"";
}

@end
