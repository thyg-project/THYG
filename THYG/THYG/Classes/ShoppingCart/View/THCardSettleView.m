//
//  THCardSettleView.m
//  THYG
//
//  Created by C on 2019/7/24.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCardSettleView.h"
#import "THButton.h"

@interface THCardSettleView()

@property (nonatomic, strong) THButton *selectedAllButton;

@property (nonatomic, strong) THButton *deleteButton;

@property (nonatomic, strong) THButton *moveButton;

@property (nonatomic, strong) THButton *shareButton;

@property (nonatomic, strong) UILabel *accountLabel;

@property (nonatomic, strong) THButton *settleButton;


@end

@implementation THCardSettleView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initinalizedView];
    }
    return self;
}

- (void)initinalizedView {
    _selectedAllButton = [THButton buttonWithType:THButtonType_imageLeft];
    _selectedAllButton.image = [UIImage imageNamed:@"unselect"];
    _selectedAllButton.selectedImage = [UIImage imageNamed:@"select"];
    _selectedAllButton.title = @"全选";
    _selectedAllButton.font = [UIFont systemFontOfSize:12];
    _selectedAllButton.margen = 8;
    [_selectedAllButton addTarget:self action:@selector(selectedAll)];
    [self addSubview:_selectedAllButton];
    _deleteButton = [THButton buttonWithType:THButtonType_Text];
    _deleteButton.textColor = [UIColor redColor];
    _deleteButton.font = [UIFont systemFontOfSize:14];
    _deleteButton.title = @"删除";
    _deleteButton.layer.masksToBounds = YES;
    _deleteButton.layer.cornerRadius = 4;
    _deleteButton.layer.borderColor = [UIColor redColor].CGColor;
    _deleteButton.layer.borderWidth = 1;
    [_deleteButton addTarget:self action:@selector(deleteAction)];
    [self addSubview:_deleteButton];
    _moveButton = [THButton buttonWithType:THButtonType_Text];
    _moveButton.textColor = [UIColor blackColor];
    _moveButton.font = [UIFont systemFontOfSize:14];
    _moveButton.title = @"移入关注";
    _moveButton.layer.masksToBounds = YES;
    _moveButton.layer.cornerRadius = 4 ;
    _moveButton.layer.borderColor = [UIColor grayColor].CGColor;
    _moveButton.layer.borderWidth = 1;
    [_moveButton addTarget:self action:@selector(moveAction)];
    [self addSubview:_moveButton];
    _shareButton = [THButton buttonWithType:THButtonType_Text];
    _shareButton.textColor = [UIColor blackColor];
    _shareButton.font = [UIFont systemFontOfSize:14];
    _shareButton.title = @"分享";
    _shareButton.layer.masksToBounds = YES;
    _shareButton.layer.cornerRadius = 4;
    _shareButton.layer.borderColor = [UIColor grayColor].CGColor;
    _shareButton.layer.borderWidth = 1;
    [_shareButton addTarget:self action:@selector(shareAction)];
    [self addSubview:_shareButton];
    _settleButton = [THButton buttonWithType:THButtonType_Text];
    _settleButton.textColor = [UIColor whiteColor];
    _settleButton.font = [UIFont systemFontOfSize:14];
    _settleButton.title = @"结算";
    _settleButton.backgroundColor = [UIColor redColor];
    [_settleButton addTarget:self action:@selector(settleAction)];
    [self addSubview:_settleButton];
    _accountLabel = [UILabel new];
    _accountLabel.font = [UIFont systemFontOfSize:14];
    _accountLabel.textAlignment = NSTextAlignmentRight;
    _accountLabel.textColor = [UIColor redColor];
    [self addSubview:_accountLabel];
    [self layoutViews];
}

- (void)layoutViews {
    [self.selectedAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@7);
        make.bottom.equalTo(@(-7));
        make.left.equalTo(@10);
        make.width.mas_equalTo(80);
    }];
    [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.selectedAllButton);
        make.right.equalTo(@(-10));
        make.width.mas_equalTo(70);
    }];
    [self.moveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.deleteButton);
        make.right.equalTo(self.deleteButton.mas_left).offset(-10);
    }];
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(self.deleteButton);
        make.right.equalTo(self.moveButton.mas_left).offset(-10);
    }];
    [self.settleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(self);
        make.width.mas_equalTo(110);
    }];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.selectedAllButton.mas_right).offset(10);
        make.right.equalTo(self.settleButton.mas_left).offset(-15);
    }];
}

- (void)setOperaType:(THCardOperaType)operaType {
    _operaType = operaType;
    self.settleButton.hidden = _operaType == THCardOperaType_Editing;
    self.accountLabel.hidden = _operaType == THCardOperaType_Editing;
    self.shareButton.hidden = _operaType == THCardOperaType_Settle;
    self.deleteButton.hidden = _operaType == THCardOperaType_Settle;
    self.moveButton.hidden = _operaType == THCardOperaType_Settle;
}

- (void)settleAction {
    if ([self.delegate respondsToSelector:@selector(settle:)]) {
        [self.delegate settle:self];
    }
}

- (void)shareAction {
    if ([self.delegate respondsToSelector:@selector(share:)]) {
        [self.delegate share:self];
    }
}

- (void)moveAction {
    if ([self.delegate respondsToSelector:@selector(move:)]) {
        [self.delegate move:self];
    }
}

- (void)deleteAction {
    if ([self.delegate respondsToSelector:@selector(deleteGoods:)]) {
        [self.delegate deleteGoods:self];
    }
}

- (void)selectedAll {
    self.selectedAllButton.selected = !self.selectedAllButton.selected;
    if ([self.delegate respondsToSelector:@selector(selectedAll:selected:)]) {
        [self.delegate selectedAll:self selected:self.selectedAllButton.selected];
    }
}

- (void)updateContentText:(NSString *)text {
    self.accountLabel.text = text;
}

@end
