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

/**
 高亮
 */
@property (nonatomic, assign) BOOL highlighted;

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
        _margen = 3.0;
        self.buttonType = buttonType;
    }
    return self;
}

+ (instancetype)buttonWithType:(THButtonType)buttonType {
    return [[self alloc] initWithButtonType:buttonType];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    _contentLabel.font = font;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = image;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _contentLabel.text = title;
}

- (void)setTextColor:(UIColor *)textColor {
    _textColor = textColor;
    _contentLabel.textColor = textColor;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (self.selectedImage && self.image) {
        _imageView.image = selected ? self.selectedImage : self.image;
    }
    if (YGInfo.validString(self.title) && YGInfo.validString(self.selectedTitle)) {
        _contentLabel.text = selected ? self.selectedTitle : self.title;
    }
    if (self.textColor && self.selectedTextColor) {
        _contentLabel.textColor = selected ? self.selectedTextColor : self.textColor;
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    _highlighted = highlighted;
    if (self.highlightTextColor) {
        _contentLabel.textColor = highlighted ? self.highlightTextColor : self.textColor;
    }
    if (self.highlightImage) {
        _imageView.image = highlighted ? self.highlightImage : self.image;
    }
}

- (void)setButtonType:(THButtonType)buttonType {
    _buttonType = buttonType;
    switch (buttonType) {
        case THButtonType_Text: {
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
                make.top.equalTo(self).offset(_margen);
                make.centerX.equalTo(self);
                make.right.equalTo(@(-_margen));
            }];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.imageView.mas_bottom).with.offset(_margen);
                make.left.right.equalTo(self);
                make.bottom.equalTo(@(-_margen));
            }];
        }
            break;
        case THButtonType_imageLeft: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(@(_margen));
            }];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageView.mas_right).offset(_margen);
                make.centerY.equalTo(self.imageView);
                make.right.equalTo(@(-_margen));
            }];
        }
            break;
        case THButtonType_imageRight: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(self);
                make.left.equalTo(@(_margen));
            }];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.imageView.mas_right).offset(_margen);
                make.centerY.equalTo(self.imageView);
                make.right.equalTo(@(-_margen));
            }];
            
        }
            break;
        case THButtonType_ImageBottom: {
            [self addSubview:self.imageView];
            [self addSubview:self.contentLabel];
            [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(@(_margen));
            }];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.contentLabel.mas_bottom).offset(_margen);
                make.centerX.equalTo(self);
            }];
           
        }
            break;
        case THButtonType_Image: {
            [self addSubview:self.imageView];
            [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_equalTo(UIEdgeInsetsMake(0, _margen, 0, _margen));
            }];
        }
            break;
    }
}

- (void)setMargen:(CGFloat)margen {
    if (_margen != margen) {
        _margen = margen;
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

- (SEL)aSelecter {
    return _aSelecter;
}

- (id)target {
    return _target;
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

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.highlighted = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
    self.highlighted = NO;
}

@end
