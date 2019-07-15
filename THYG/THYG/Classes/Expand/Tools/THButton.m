//
//  THButton.m
//  THYG
//
//  Created by C on 2019/7/10.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THButton.h"

@interface THButton() {
    SEL _aSelecter;
    id _target;
}

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, assign) THButtonType buttonType;

@end

@implementation THButton

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeCenter;
        _imageView.userInteractionEnabled = YES;
    }
    return _imageView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _contentLabel;
}

- (instancetype)initWithButtonType:(THButtonType)buttonType {
    if (self = [super init]) {
        self.buttonType = buttonType;
    }
    return self;
}

- (void)setFont:(UIFont *)font {
    self.contentLabel.font = font;
}

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
}

- (void)setTitle:(NSString *)title {
    self.contentLabel.text = title;
}

- (void)setTextColor:(UIColor *)textColor {
    self.contentLabel.textColor = textColor;
}

- (void)setButtonType:(THButtonType)buttonType {
    _buttonType = buttonType;
    switch (buttonType) {
        case THButtonType_None: {
            [self addSubview:self.contentLabel];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(self);
            }];
        }
            break;
        case THButtonType_imageTop: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(3);
                make.centerX.equalTo(self);
            }];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imageView.mas_bottom).with.offset(3);
                make.left.right.equalTo(self);
                make.bottom.equalTo(@(-3));
            }];
        }
            break;
        case THButtonType_imageLeft: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(@(3));
                
            }];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageView.mas_right).offset(3);
                make.centerY.equalTo(self.imageView);
            }];
        }
            break;
        case THButtonType_imageRight: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(@(3));
            }];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageView.mas_right).offset(3);
                make.centerY.equalTo(self.imageView);
            }];
            
        }
            break;
        case THButtonType_ImageBottom: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(@(3));
            }];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(3);
                make.centerX.equalTo(self);
            }];
           
        }
            break;
        case THButtonType_OnlyImage: {
            [self addSubview:self.imageView];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, 3, 0, 3));
            }];
        }
            break;
    }
}

- (void)setMargen:(CGFloat)margen {
    _margen = margen;
    if (margen != 3.0) {
        switch (self.buttonType) {
            case THButtonType_imageTop: {
                [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.imageView.mas_bottom).with.offset(_margen);
                }];
            }
                break;
            case THButtonType_imageLeft: {
                [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.imageView.mas_right).offset(_margen);
                }];
            }
                break;
            case THButtonType_imageRight: {
                [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                   make.left.equalTo(self.imageView.mas_right).offset(_margen);
                }];
            }
                break;
            case THButtonType_ImageBottom: {
                [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.contentLabel.mas_bottom).offset(_margen);
                }];
            }
                break;
                
            default:
                break;
        }
    }
}

- (void)addTarget:(id)target action:(SEL)action {
    _aSelecter = action;
    _target = target;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)]];
}

- (void)tapGesture:(UITapGestureRecognizer *)ges {
    if ([_target respondsToSelector:_aSelecter]) {
        NSArray *array = [NSStringFromSelector(_aSelecter) componentsSeparatedByString:@":"];
        if (array.count == 2) {
            ((void (*)(id,SEL,id))objc_msgSend)(_target,_aSelecter,ges.view);
        } else {
            ((void (*)(id,SEL))objc_msgSend)(_target,_aSelecter);
        }
    }
}


@end
