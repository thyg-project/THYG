//
//  THMineNavigationView.m
//  THYG
//
//  Created by C on 2019/7/15.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THNavigationView.h"
#import "THButton.h"

static NSInteger const kRightButtonTag = 100;

@interface THNavigationView() {
    UILabel *_titleLabel;
    
    THButton *_leftButton;
    
}

@property (nonatomic, strong) THButton *rightButton;

@end

@implementation THNavigationView

- (THButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[THButton alloc] initWithButtonType:THButtonType_None];
        [_rightButton addTarget:self action:@selector(rightAction:)];
    }
    return _rightButton;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initinalieViews];
    }
    return self;
}

- (void)setTitleView:(UIView *)titleView {
    if (!titleView) {
        return;
    }
    _titleView = titleView;
    _titleLabel.hidden = YES;
    [self addSubview:_titleView];
    [_titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kStatesBarHeight));
        make.bottom.equalTo(self);
        make.left.equalTo(@(80));
        make.right.equalTo(@(-80));
    }];
}

- (void)initinalieViews {
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:18];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.numberOfLines = 0;
    [_titleLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(contentGesture:)]];
    [self addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kStatesBarHeight));
        make.bottom.equalTo(self);
        make.left.equalTo(@(80));
        make.right.equalTo(@(-80));
    }];
    _leftButton = [[THButton alloc] initWithButtonType:THButtonType_OnlyImage];
    _leftButton.image = [UIImage imageNamed:@"back_white"];
    [self addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(@(kStatesBarHeight));
        make.bottom.equalTo(self);
    }];
    [_leftButton addTarget:self action:@selector(backAction)];
}

- (void)setContent:(NSString *)content {
    _titleLabel.text = content;
}

- (void)setTextColor:(UIColor *)textColor {
    _titleLabel.textColor = textColor;
}

- (void)setLeftButtonImage:(UIImage *)leftButtonImage {
    if (!leftButtonImage) {
        _leftButton.hidden = YES;
        return;
    }
    _leftButton.hidden = NO;
    _leftButton.image = leftButtonImage;
}

- (void)setLeftButtonTitle:(NSString *)leftButtonTitle {
    [_leftButton removeFromSuperview];
    _leftButton = [[THButton alloc] initWithButtonType:THButtonType_None];
    _leftButton.title = leftButtonTitle;
    [self addSubview:_leftButton];
    [_leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(5);
        make.top.equalTo(@(kStatesBarHeight));
        make.bottom.equalTo(self);
    }];
    [_leftButton addTarget:self action:@selector(backAction)];
}

- (void)setRightButtonImage:(UIImage *)rightButtonImage {
    [_rightButton removeFromSuperview];
    [self addSubview:self.rightButton];
    self.rightButton.image = rightButtonImage;
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(@(kStatesBarHeight));
        make.bottom.equalTo(self);
    }];
}

- (void)setRightButtonTitle:(NSString *)rightButtonTitle {
    [_rightButton removeFromSuperview];
    [self addSubview:self.rightButton];
    self.rightButton.title = rightButtonTitle;
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-10));
        make.top.equalTo(@(kStatesBarHeight));
        make.bottom.equalTo(self);
    }];
}

- (void)setRightButtonTitles:(NSArray<NSString *> *)rightButtonTitles {
    _rightButtonTitles = rightButtonTitles;
    [self clear];
    UIView *lastView = nil;
    for (int i = 0; i < rightButtonTitles.count; i ++) {
        THButton *button = [[THButton alloc] initWithButtonType:THButtonType_None];
        button.tag = kRightButtonTag + i;
        button.title = rightButtonTitles[i];
        [button addTarget:self action:@selector(rightAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kStatesBarHeight));
            make.bottom.equalTo(@(0));
            if (lastView) {
                make.right.equalTo(lastView.mas_left).offset(-5);
            } else {
                make.right.equalTo(@(-10));
            }
        }];
        lastView = button;
    }
}

- (void)setRightButtonsImages:(NSArray<UIImage *> *)rightButtonsImages {
    [self clear];
    UIView *lastView = nil;
    for (int i = 0; i < rightButtonsImages.count; i ++) {
        THButton *button = [[THButton alloc] initWithButtonType:THButtonType_OnlyImage];
        button.tag = kRightButtonTag + i;
        button.image = rightButtonsImages[i];
        [button addTarget:self action:@selector(rightAction:)];
        [self addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(kStatesBarHeight));
            make.bottom.equalTo(@(0));
            if (lastView) {
                make.right.equalTo(lastView.mas_left).offset(-5);
            } else {
                make.right.equalTo(@(-10));
            }
        }];
        lastView = button;
    }
}

- (void)setBackTextFont:(UIFont *)backTextFont {
    if (_leftButton) {
        _leftButton.font = backTextFont;
    }
}

- (void)setBackTextColor:(UIColor *)backTextColor {
    if (_leftButton) {
        _leftButton.textColor = backTextColor;
    }
}

- (void)setContentSize:(UIFont *)contentSize {
    _titleLabel.font = contentSize;
}

- (void)setRightTextFont:(UIFont *)rightTextFont {
    if (_rightButton) {
        _rightButton.font = rightTextFont;
        return;
    }
    if (_rightButtonTitles) {
        for (int i = 0; i < _rightButtonTitles.count; i ++) {
            THButton *button = [self viewWithTag:kRightButtonTag + i];
            button.font = rightTextFont;
        }
    }
}

- (void)setRightTextColor:(UIColor *)rightTextColor {
    if (_rightButton) {
        _rightButton.textColor = rightTextColor;
        return;
    }
    if (_rightButtonTitles) {
        for (int i = 0; i < _rightButtonTitles.count; i ++) {
            THButton *button = [self viewWithTag:kRightButtonTag + i];
            button.textColor = rightTextColor;
        }
    }
}

- (void)setAttributedContent:(NSAttributedString *)attributedContent {
    _titleLabel.attributedText = attributedContent;
}

- (void)backAction {
    if ([self.delegate respondsToSelector:@selector(back)]) {
        [self.delegate back];
    }
}

- (void)rightAction:(THButton *)button {
    if ([self.delegate respondsToSelector:@selector(rightAction:)]) {
        NSInteger tag = button.tag;
        if (tag >= kRightButtonTag) {
            tag = tag - kRightButtonTag;
        }
        [self.delegate rightAction:tag];
    }
}

- (void)contentGesture:(UITapGestureRecognizer *)gesture {
    if ([self.delegate respondsToSelector:@selector(contentDidTouch:)]) {
        UILabel *label = (UILabel *)gesture.view;
        [self.delegate contentDidTouch:label.text ? : label.attributedText];
    }
}

- (void)clear {
    for (UIView *view in self.subviews) {
        if (view.tag >= 100) {
            [view removeFromSuperview];
        }
    }
}

@end
