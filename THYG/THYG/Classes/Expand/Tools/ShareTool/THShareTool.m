//
//  THShareTool.m
//  THYG
//
//  Created by Victory on 2018/6/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShareTool.h"
#define UMENG_APPKEY @"5b2dbda68f4a9d0bf300005e"
#import <UMShare/UMShare.h>
#import <UMShare/UMSocialManager.h>
#import <UMCommon/UMCommon.h>

@implementation THShareTool

+ (void)shareGraphicToPlatformType:(UMSocialPlatformType)platformType
					  ContentText:(NSString *)ContentText
						thumbnail:(id)thumbnail
					   shareImage:(id)shareImage
						  success:(success)success
						  failure:(failure)failure {
	UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
	ContentText ? (messageObject.text = ContentText) : nil;
	UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
	shareObject.thumbImage = thumbnail;
	[shareObject setShareImage:shareImage];
	messageObject.shareObject = shareObject;
	
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			failure(error);
		}else{
			success(data);
		}
	}];
}

+ (void)shareMultimediaToPlatformType:(UMSocialPlatformType)platformType
					ShareContentType:(ShareContentType)ShareContentType
							   title:(NSString *)title
				  contentDescription:(NSString *)contentDescription
						   thumbnail:(id)thumbnail
								 url:(NSString *)url
						   StreamUrl:(NSString *)StreamUrl
							 success:(success)success
							 failure:(failure)failure {
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
	
	[[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
		if (error) {
			failure(error);
		}else{
			success(data);
		}
	}];
}

+ (void)configShareSDK {
    [UMConfigure initWithAppkey:UMENG_APPKEY channel:nil];
#ifdef Debug
    [UMConfigure setLogEnabled:YES];
#else
    [UMConfigure setLogEnabled:NO];
#endif
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"" appSecret:@"" redirectURL:@""];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:@"" appSecret:@"" redirectURL:@""];
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"" appSecret:@"" redirectURL:@""];
}

@end
