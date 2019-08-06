//
//  THGuideViewTool.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGuideViewTool.h"
#import "THNewFeatureVC.h"
#import "THTabBarController.h"

@implementation THGuideViewTool

+ (UIViewController *)chooseRootViewController {
	// 获取用户最新的版本号，info.plist
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	NSString *lastVersion = [defaults objectForKey:@"appVersion"];
	NSString *currentVersion = YGInfo.appVersion();
	if ([currentVersion isEqualToString:lastVersion]) { // 广告页面
		THTabBarController *tabbarVc = [[THTabBarController alloc] init];
		return tabbarVc;
		
	} else { // 新特性页面
		return [[THNewFeatureVC alloc] init];
	}
}

@end
