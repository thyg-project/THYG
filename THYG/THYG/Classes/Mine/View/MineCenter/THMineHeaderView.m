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
    if (THUserManager.hasLogin) {
        self.headImgView.image = [UIImage imageNamed:@"member-head-bg.png"];
        [self.userImgView setImageWithURL:[NSURL URLWithString:THUserManager.sharedInstance.userInfo.head_pic] placeholder:[UIImage imageNamed:@"touxiang"]];
        self.userNameLabel.text = THUserManager.sharedInstance.userInfo.nickname ? : @"未设置";
    } else {
        self.headImgView.image = [UIImage imageNamed:@"member-head-bg.png"];
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
    _userNameLabel = [[UILabel alloc]init];
    _userNameLabel.textColor = [UIColor whiteColor];
    if (@available(iOS 8.2, *)) {
        _userNameLabel.font = [UIFont systemFontOfSize:20 weight:2];
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
    
    _headImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 140 + kStatesBarHeight)];
    _headImgView.image = [UIImage imageNamed:@"noLogin"];
    
    [self addSubview:self.headImgView];
    [self addSubview:self.userImgView];
    [self addSubview:self.userNameLabel];
    [self addSubview:self.checkOnBtn];
    [self.userImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(19);
        make.top.equalTo(@(56 + kStatesBarHeight));
        make.width.height.offset(54);
    }];
    
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userImgView.mas_right).offset(12);
        make.centerY.equalTo(self.userImgView.mas_centerY);
    }];
    
}

@end
