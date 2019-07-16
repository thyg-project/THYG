//
//  Macros.h
//  THYG
//
//  Created by Victory on 2018/3/14.
//  Copyright © 2018年 THYG. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define kBigBang          YGInfo.isBangScreen()
//iPhone X 顶部44pt  底部34pt
#define kTabBarHeight  (kBigBang ? 83 : 49)                   // 定义Tabbar高度
#define kNaviHeight  (kBigBang ? 88 : 64)                   // 导航栏高度
#define kStatesBarHeight  (kBigBang ? 44 : 20)

//iPhone X 底部home区域 34pt
#define kTabBarBottomMargen  (kBigBang ? 34 : 0)
//适配上
#define WIDTH(W) [UIScreen mainScreen].bounds.size.width / 375 * W

/** 弱引用 */
#define kWeakSelf __weak __typeof(self) weakSelf = self;

#define kStrongSelf __strong __typeof(weakSelf) strongSelf = weakSelf;

#define kWeakObject(object) __weak __typeof(object) weakObject = object;
/*****************  屏幕适配  ******************/

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

// 灰色
#define GRAY_COLOR(r) RGB(r,r,r)
#define GRAY(r,a) RGBA(r,r,r,a)
#define GLOBAL_RED_COLOR RGB(213,0,27)

//线条颜色统一
#define LINECOLOR RGB(229, 229, 229)
//全局背景色
#define BGColor RGB(245,245,245)
#define GRAY_102 GRAY_COLOR(102)
#define GRAY_51 GRAY_COLOR(51)
#define GRAY_151 GRAY_COLOR(151)


#define Font(size) [UIFont systemFontOfSize:size]


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif


#endif /* Macros_h */
