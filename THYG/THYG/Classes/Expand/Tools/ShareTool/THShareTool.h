//
//  THShareTool.h
//  THYG
//
//  Created by Victory on 2018/6/23.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMCommon/UMCommon.h>
#import <UMShare/UMShare.h>

typedef NS_ENUM(NSUInteger, ShareContentType) {
	ShareContentTypeWeb = 1,//网页
	ShareContentTypeMusic,  //音乐
	ShareContentTypeVideo,  //视频
};

typedef void (^success)(id result);
typedef void (^failure)(NSError *error);

@interface THShareTool : NSObject


//==================================================
// 分享功能(适用自定义分享UI页面)
//==================================================
/**
 *  图文分享
 *
 *  @param platformType 平台类型 @see UMSocialPlatformType
 *  @param ContentText  文本(纯图可以为nil)
 *  @param thumbnail    缩略图
 *  @param shareImage   分享图片
 */
+ (void)shareGraphicToPlatformType:(UMSocialPlatformType)platformType
                       contentText:(NSString *)ContentText
                         thumbnail:(id)thumbnail
                        shareImage:(id)shareImage
                  currentContainer:(UIViewController *)container
                           success:(success)success
                           failure:(failure)failure;
/**
 *  多媒体分享	·
 *
 *  @param platformType       平台类型 @see UMSocialPlatformType
 *  @param ShareContentType   分享多媒体类型 @see ShareContentType
 *  @param title              标题
 *  @param contentDescription 分享描述
 *  @param thumbnail          缩略图
 *  @param url                内容网页地址
 *  @param StreamUrl          数据流地址
 */
+ (void)shareMultimediaToPlatformType:(UMSocialPlatformType)platformType
                     shareContentType:(ShareContentType)ShareContentType
                                title:(NSString *)title
                   contentDescription:(NSString *)contentDescription
                            thumbnail:(id)thumbnail
                                  url:(NSString *)url
                            streamUrl:(NSString *)StreamUrl
                     currentContainer:(UIViewController *)container
                              success:(success)success
                              failure:(failure)failure;






+ (void)configShareSDK;

@end
