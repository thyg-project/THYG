//
//  THMineHeaderView.m
//  THYG
//
//  Created by Victory on 2018/3/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THMineHeaderView.h"

@interface THMineHeaderView()
@property (nonatomic, strong) UIImageView *userImgView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) UIButton *checkOnBtn;
@end

@implementation THMineHeaderView

#pragma mark - Intial
- (instancetype)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
        [self initinalizedViews];
	}
	return self;
}

- (void)refreshUI {
    if ([@"" length]) {
        self.headImgView.image = [UIImage imageNamed:@"beijing"];
//        [self.userImgView sd_setImageWithURL:[NSURL URLWithString:UserInfo.head_pic] placeholderImage:[UIImage imageNamed:@"touxiang"]];
//        self.userNameLabel.text = UserInfo.nickname;
    } else {
        self.headImgView.image = [UIImage imageNamed:@"noLogin"];
        self.userImgView.image = [UIImage imageNamed:@"touxiang"];
        self.userNameLabel.text = @"登录 / 注册";
    }
}

- (void)gotoMotifyPage {
    if ([self.delegate respondsToSelector:@selector(toUserInfo:)]) {
        [self.delegate toUserInfo:self];
    }
}

#pragma mark - 签到
- (void)checkOnClick:(UIButton *)btn {
    if ([self.delegate respondsToSelector:@selector(sign:)]) {
        [self.delegate sign:self];
    }
}

- (void)udpateSignState {
    self.checkOnBtn.selected = YES;
}

- (void)initinalizedViews {
    _checkOnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_checkOnBtn setTitleColor:RGB(255, 216, 0) forState:UIControlStateNormal];
    [_checkOnBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    _checkOnBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [_checkOnBtn setTitle:@"签到" forState:UIControlStateNormal];
    [_checkOnBtn setTitle:@"已签到" forState:UIControlStateSelected];
    [_checkOnBtn addTarget:self action:@selector(checkOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_checkOnBtn setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal];
    [_checkOnBtn setBackgroundImage:[UIImage imageWithColor:RGB(255, 216, 0)] forState:UIControlStateSelected];
    _checkOnBtn.layer.borderWidth = 1;
    _checkOnBtn.layer.cornerRadius = 12.5;
    _checkOnBtn.layer.borderColor = RGB(255, 216, 0).CGColor;
    
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.textColor = [UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        _userNameLabel.font = [UIFont systemFontOfSize:16 weight:2];
    }
    _userNameLabel.text = @"登录 / 注册";
    _userNameLabel.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMotifyPage)];
    [_userNameLabel addGestureRecognizer:tap];
    
    _userImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang"]];
    _userImgView.contentMode = UIViewContentModeScaleAspectFill;
    _userImgView.layer.cornerRadius = 28;
    _userImgView.clipsToBounds = YES;
    _userImgView.userInteractionEnabled = YES;
    [_userImgView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gotoMotifyPage)]];
    
    _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100+kNaviHeight)];
    _headImgView.image = [UIImage imageNamed:@"noLogin"];
    
    [self addSubview:self.headImgView];
    [self addSubview:self.userImgView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.checkOnBtn];
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(25);
        make.bottom.offset(-25);
        make.width.height.offset(56);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImgView.mas_right).offset(10);
        make.centerY.equalTo(self.userImgView.mas_centerY);
    }];
    
    [self.checkOnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-20);
        make.centerY.equalTo(self.userNameLabel.mas_centerY);
        make.width.offset(60);
        make.height.offset(25);
    }];
    
}

@end
