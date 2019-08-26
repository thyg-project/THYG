//
//  YGUtils.m
//  YaloGame
//
//  Created by C on 2018/11/17.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGInfo.h"
#include <sys/sysctl.h>
#import <YYKit/YYKeychain.h>
static NSString *const kKeychain = @"THYG.com";

static BOOL validString(NSString *string) {
    return (string && [string isKindOfClass:[NSString class]] && string.length > 0);
}

static BOOL validArray(NSArray *array) {
    return (array && [array isKindOfClass:[NSArray class]] && array.count > 0);
}

static BOOL isBangScreen(void) {
    static BOOL bangScreen = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        bangScreen = [UIApplication sharedApplication].statusBarFrame.size.height > 20;
    });
    return bangScreen;
}

static CGFloat statesBarHeight(void) {
    CGFloat stateBarHeight = 20;
    CGFloat temp = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    stateBarHeight = temp > 0 ? temp : 20;
    return stateBarHeight;
}

static UIEdgeInsets applicationSafeAreaInsets(void) {
    UIEdgeInsets safeAreaInsets = {0,0,0,0};
    if (@available(iOS 11.0, *)) {
        safeAreaInsets = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
    }
    return safeAreaInsets;
}

static BOOL validDictionary(NSDictionary *dictionary) {
    return (dictionary && [dictionary isKindOfClass:[NSDictionary class]] && dictionary.count > 0);
}

static NSURL *URLFromString(NSString *urlStr) {
    if (YGInfo.validString(urlStr)) {
        return [NSURL URLWithString:[urlStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
    }
    return nil;
}

static NSString *IDFV(void) {
    static NSString *idfv = nil;
    if (idfv) return idfv;
    idfv = [YYKeychain getPasswordForService:@"xu.cheng" account:kKeychain];
    if (idfv) {
        return idfv;
    }
    idfv = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    if (idfv) {
        BOOL result = [YYKeychain setPassword:idfv forService:@"xu.cheng" account:kKeychain];
        NSLog(result ? @"设置idfv成功" : @"设置idfv失败");
    }
    return idfv;
}

static NSString *appVersion(void) {
    static NSString *version = nil;
    if (version) return version;
    version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}

static NSString *deviceVersion(void) {
    static NSString *deviceV = nil;
    if (deviceV) return deviceV;
    deviceV = [[UIDevice currentDevice] systemVersion];
    return deviceV;
}

static NSString *deviceModel(void) {
    static NSString *platform = nil;
    if (platform) {
        return platform;
    }
    
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    NSDictionary *dic = @{@"iPhone1,1" :  @"iPhone 2G (A1203)",
                          @"iPhone1,2" :  @"iPhone 3G (A1241/A1324)",
                          @"iPhone2,1" :  @"iPhone 3GS (A1303/A1325)",
                          @"iPhone3,1" :  @"iPhone 4 (A1332)",
                          @"iPhone3,2" :  @"iPhone 4 (A1332)",
                          @"iPhone3,3" :  @"iPhone 4 (A1349)",
                          @"iPhone4,1" :  @"iPhone 4S (A1387/A1431)",
                          @"iPhone5,1" :  @"iPhone 5 (A1428)",
                          @"iPhone5,2" :  @"iPhone 5 (A1429/A1442)",
                          @"iPhone5,3" :  @"iPhone 5c (A1456/A1532)",
                          @"iPhone5,4" :  @"iPhone 5c (A1507/A1516/A1526/A1529)",
                          @"iPhone6,1" :  @"iPhone 5s (A1453/A1533)",
                          @"iPhone6,2" :  @"iPhone 5s (A1457/A1518/A1528/A1530)",
                          @"iPhone7,1" :  @"iPhone 6 Plus (A1522/A1524)",
                          @"iPhone7,2" :  @"iPhone 6 (A1549/A1586)",
                          @"iPhone8,1" :  @"iPhone 6s (A1633/A1688)",
                          @"iPhone8,2" :  @"iPhone 6s Plus (A1634/A1687)",
                          @"iPhone8,4" :  @"iPhone SE (A1622/A1723)",
                          @"iPhone9,1" :  @"iPhone 7",
                          @"iPhone9,3" :  @"iPhone 7",
                          @"iPhone9,2" :  @"iPhone 7 Plus",
                          @"iPhone9,4" :  @"iPhone 7 Plus",
                          @"iPhone10,1":  @"iPhone 8",
                          @"iPhone10,4":  @"iPhone 8",
                          @"iPhone10,2":  @"iPhone 8 Plus",
                          @"iPhone10,5":  @"iPhone 8 Plus",
                          @"iPhone10,3":  @"iPhone X",
                          @"iPhone10,6":  @"iPhone X",
                          @"iPhone11,2":  @"iPhone XS",
                          @"iPhone11,4":  @"iPhone XS Max",
                          @"iPhone11,6":  @"iPhone XS Max",
                          @"iPhone11,8":  @"iPhone XR",
                          
                          @"iPad1,1"  :  @"iPad 1G (A1219/A1337)",
                          @"iPad2,1"  :  @"iPad 2 (A1395)",
                          @"iPad2,2"  :  @"iPad 2 (A1396)",
                          @"iPad2,3"  :  @"iPad 2 (A1397)",
                          @"iPad2,4"  :  @"iPad 2 (A1395+New Chip)",
                          @"iPad2,5"  :  @"iPad Mini 1G (A1432)",
                          @"iPad2,6"  :  @"iPad Mini 1G (A1454)",
                          @"iPad2,7"  :  @"iPad Mini 1G (A1455)",
                          @"iPad3,1"  :  @"iPad 3 (A1416)",
                          @"iPad3,2"  :  @"iPad 3 (A1403)",
                          @"iPad3,3"  :  @"iPad 3 (A1430)",
                          @"iPad3,4"  :  @"iPad 4 (A1458)",
                          @"iPad3,5"  :  @"iPad 4 (A1459)",
                          @"iPad3,6"  :  @"iPad 4 (A1460)",
                          @"iPad4,1"  :  @"iPad Air (A1474)",
                          @"iPad4,2"  :  @"iPad Air (A1475)",
                          @"iPad4,3"  :  @"iPad Air (A1476)",
                          @"iPad4,4"  :  @"iPad Mini 2G (A1489)",
                          @"iPad4,5"  :  @"iPad Mini 2G (A1490)",
                          @"iPad4,6"  :  @"iPad Mini 2G (A1491)",
                          @"iPad4,7"  :  @"iPad Mini 3 (A1599)",
                          @"iPad4,8"  :  @"iPad Mini 3 (A1600)",
                          @"iPad4,9"  :  @"iPad Mini 3 (A1601)",
                          @"iPad5,1"  :  @"iPad Mini 4 (A1538)",
                          @"iPad5,2"  :  @"iPad Mini 4 (A1550)",
                          @"iPad5,3"  :  @"iPad Air 2 (A1566)",
                          @"iPad5,4"  :  @"iPad Air 2 (A1567)",
                          @"iPad6,3"  :  @"iPad Pro(9,7 inch) (A1673)",
                          @"iPad6,4"  :  @"iPad Pro(9,7 inch) (A1674/A1675)",
                          @"iPad6,7"  :  @"iPad Pro(12.9 inch) (A1584)",
                          @"iPad6,8"  :  @"iPad Pro(12.9 inch) (A1652)",
                          @"iPad7,4"  :  @"iPad Pro(10,5 inch)",
                          
                          @"i386"     :  @"iPhone Simulator",
                          @"x86_64"   :  @"iPhone Simulator"};
    if (platform) {
        platform = dic[platform] ? : platform;
    }else {
        platform = @"unknown";
    }
    return platform;
}

YGInfo_t YGInfo = {
    validString,
    validArray,
    validDictionary,
    isBangScreen,
    URLFromString,
    IDFV,
    appVersion,
    deviceVersion,
    deviceModel,
    applicationSafeAreaInsets,
    statesBarHeight,
};

