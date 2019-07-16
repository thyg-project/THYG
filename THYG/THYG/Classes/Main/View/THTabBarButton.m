//
//  THTabBarButton.m
//  THYG
//
//  Created by Mac on 2018/5/16.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTabBarButton.h"
#import <MJRefresh/UIView+MJExtension.h>

@implementation THTabBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:10];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.adjustsImageWhenHighlighted = NO;
        // 2.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 文字位置
    self.titleLabel.left = 0;
    self.titleLabel.width = self.width;
    self.titleLabel.height = 16;
    if (@available(iOS 11.0, *)) {
        self.titleLabel.height -= 1;
    }
    self.titleLabel.top = self.height - self.titleLabel.height;
    
    // 图片位置
    self.imageView.width = self.currentImage.size.width;
    self.imageView.height = self.currentImage.size.height;
    self.imageView.left = (self.width - self.imageView.width) / 2;
    self.imageView.top = self.titleLabel.top - self.imageView.height - 4;
    
}

@end
