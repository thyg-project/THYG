//
//  THGoodsDetailBottomView.m
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsDetailBottomView.h"
#import "UIButton+extentedButton.h"

@interface THGoodsDetailBottomView ()

@end

@implementation THGoodsDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    NSArray *titles = @[@"客服"/*,@"关注"*/,@"购物车",@"加入购物车"/*,@"立即购买"*/];
    NSArray *norImages = @[@"kefu"/*,@"guanzhu"*/,@"tianjiagouwuche"];
    NSArray *selImages = @[@"kefu"/*,@"guanzhu"*/,@"gouwuche_sel"];
    for (NSInteger i = 0; i < titles.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        if (i < 2) {
            [btn setImage:[UIImage imageNamed:norImages[i]] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:selImages[i]] forState:UIControlStateSelected];
//            if (i==1) {
//                [btn setTitle:@"已关注" forState:UIControlStateSelected];
//            }
        }
        btn.titleLabel.font = [UIFont systemFontOfSize:i < 2 ? 11 : 14];
        [btn setTitleColor:(i < 2)?UIColor.grayColor:UIColor.yellowColor forState:UIControlStateNormal];
        [btn setBackgroundColor:((i == 2) ?  UIColor.redColor : UIColor.whiteColor)];
//        [btn setBackgroundColor:((i > 2) ? ((i == 3) ? RGB(252, 85, 8): UIColor.redColor) : UIColor.whiteColor)];
        [self addSubview:btn];
        CGFloat width = 0;
        CGFloat leftX = 0;
        if (i < 2) {
            width = kScreenWidth / 4;
            leftX = width * i;
        } else {
            width = kScreenWidth / 2;
            leftX = width;
        }
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(leftX));
            make.top.equalTo(@(0.8));
            make.width.mas_equalTo(width);
            make.bottom.equalTo(self);
        }];
        [btn addTarget:self action:@selector(buttomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.tag < 2) {
                [btn layoutButtonWithEdgeInsetsStyle:ButtonEdgeInsetsStyleTop imageTitleSpace:2];
            }
        }
    }
}

- (void)buttomButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(bottomViewDidSelectedIndex:)]) {
        [self.delegate bottomViewDidSelectedIndex:sender.tag];
    }
}

@end
