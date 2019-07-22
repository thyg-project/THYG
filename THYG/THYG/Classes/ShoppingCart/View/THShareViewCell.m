//
//  THShareViewCell.m
//  THYG
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShareViewCell.h"
#import "THButton.h"

@interface THShareViewCell ()
@property (nonatomic, strong) THButton *btn;
@end

@implementation THShareViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.btn];
        [self.btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView);
        }];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    _btn.image = [UIImage imageNamed:_imageName];
}

- (void)setIconName:(NSString *)iconName {
    _iconName = iconName;
    _btn.title = _iconName;
}

- (THButton *)btn {
    if (!_btn) {
        _btn = [[THButton alloc] initWithButtonType:THButtonType_imageTop];
        _btn.textColor = RGB(51, 51, 51);
        _btn.userInteractionEnabled = NO;
        _btn.font = [UIFont systemFontOfSize:12];
    }
    return _btn;
}

@end
