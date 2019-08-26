//
//  THShareTool.m
//  THYG
//
//  Created by Victory on 2018/6/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShareTool.h"//5d633c0e0cafb2a2ea00078b,5b2dbda68f4a9d0bf300005e
#define UMENG_APPKEY @"5d633c0e0cafb2a2ea00078b"
#import <UMShare/UMShare.h>
#import <UMShare/UMSocialManager.h>
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>

@implementation THShareTool

+ (void)shareGraphicToPlatformType:(UMSocialPlatformType)platformType contentText:(NSString *)ContentText thumbnail:(id)thumbnail shareImage:(id)shareImage currentContainer:(UIViewController *)container success:(success)success failure:(failure)failure {
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	ContentText ? (messageObject.text = ContentText) : nil;
	UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
	shareObject.thumbImage = thumbnail;
	[shareObject setShareImage:shareImage];
	messageObject.shareObject = shareObject;
	
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:container completion:^(id data, NSError *error) {
		if (error) {
			failure(error);
		}else{
			success(data);
		}
	}];
}

+ (void)shareMultimediaToPlatformType:(UMSocialPlatformType)platformType shareContentType:(ShareContentType)ShareContentType title:(NSString *)title contentDescription:(NSString *)contentDescription thumbnail:(id)thumbnail url:(NSString *)url streamUrl:(NSString *)StreamUrl currentContainer:(UIViewController *)container success:(success)success failure:(failure)failure {
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	
	switch (ShareContentType) {
		case ShareContentTypeWeb:{
			
			UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:contentDescription thumImage:thumbnail];
			shareObject.webpageUrl = url;
			messageObject.shareObject = shareObject;
		}
			break;
		case ShareContentTypeMusic:{
			
			UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:contentDescription thumImage:thumbnail];
			shareObject.musicUrl = url;
			shareObject.musicDataUrl = StreamUrl;
			messageObject.shareObject = shareObject;
		}
			break;
		case ShareContentTypeVideo:{
			
			UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:contentDescription thumImage:thumbnail];
			shareObject.videoUrl = url;
			shareObject.videoStreamUrl = StreamUrl;
			messageObject.shareObject = shareObject;
		}
			break;
		default:
			break;
	}
	
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:container completion:^(id data, NSError *error) {
		if (error) {
			failure(error);
		}else{
			success(data);
		}
	}];
}

+ (void)configShareSDK {
    [UMConfigure initWithAppkey:UMENG_APPKEY channel:@"AppStore"];
#ifdef DEBUG
    [UMConfigure setLogEnabled:YES];
    [UMCommonLogManager setUpUMCommonLogManager];
#else
    [UMConfigure setLogEnabled:NO];
#endif
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"" appSecret:@"" redirectURL:@""];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:UMENG_APPKEY appSecret:@"" redirectURL:@""];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"1502380040" appSecret:@"b80116628ef32b919c04090e883f17d6" redirectURL:@""];
}

@end
