#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "MWCaptionView.h"
#import "MWPhoto.h"
#import "MWPhotoBrowser.h"
#import "MWPhotoProtocol.h"
#import "MWTapDetectingImageView.h"
#import "MWTapDetectingView.h"
#import "MWZoomingScrollView.h"

FOUNDATION_EXPORT double MWPhotoBrowserVersionNumber;
FOUNDATION_EXPORT const unsigned char MWPhotoBrowserVersionString[];

