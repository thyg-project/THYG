//
//  UIImage+CHImage.h
//  CheHu
//
//  Created by Victory on 2017/6/12.
//  Copyright © 2017年 iKaibei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CHImage)
// 将一张彩色图片转换为灰色图片
+ (UIImage*)systemImageToGray:(UIImage*)image;

/**
 * 返回一张未经过渲染的图片
 */
+ (UIImage *)imageWithOrignalImageNamed:(NSString *)image;

/**
 * 通过颜色创建图片
 */
+ (UIImage*)imageWithColor:(UIColor*)color;

/**  返回圆形图片*/
- (UIImage *)circleImage;

/**  返回圆形图片*/
+ (UIImage *)circleImageWithName:(NSString *)name;

/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+ (UIImage *)imgCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth;


+ (UIImage *)stretchableImage:(NSString *)imageName;

// 改变图像的尺寸
+ (UIImage *)resizeImage:(NSString *)imageName;

- (UIImage *)scaleToSize:(CGSize) size;

/**
 *  创建自定义占位图片
 */
+ (UIImage *)createPlaceholderImageWithSize:(CGSize)size;

+ (UIImage *)drawImageWithStartColor:(UIColor *)startColor
                            endColor:(UIColor *)endColor
                              bounds:(CGRect)bounds
                          startPoint:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint;

@end
