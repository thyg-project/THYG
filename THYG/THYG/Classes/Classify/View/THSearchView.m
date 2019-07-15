//
//  THSearchView.m
//  THYG
//
//  Created by Mac on 2018/5/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSearchView.h"
#import "THButton.h"

@interface THSearchView () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate> {
    BOOL _isCancel;
}
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) THButton *searchButton;

@property (nonatomic, strong) UITableView *resultTableView;


@end

@implementation THSearchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGB(59, 59, 59);
        self.textField = ({
            UITextField *field = [[UITextField alloc] init];
            field.placeholder = @"商品关键字";
            field.font = [UIFont systemFontOfSize:13];
            field.textColor = GRAY_151;
            field.backgroundColor = [UIColor whiteColor];
            field.delegate = self;
            field.layer.cornerRadius = 34 * 0.5;
            field.layer.masksToBounds = YES;
            field.clearButtonMode = UITextFieldViewModeWhileEditing;
            field.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 34)];
            field.leftViewMode = UITextFieldViewModeAlways;
            field;
        });
        [self addSubview:self.textField];
        _searchButton = [[THButton alloc] initWithButtonType:THButtonType_None];
        [self addSubview:self.searchButton];
        self.searchButton.font = [UIFont systemFontOfSize:16];
        self.searchButton.textColor = [UIColor yellowColor];
        self.searchButton.title = @"搜索";
        [self.searchButton addTarget:self action:@selector(searchAction)];
        [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.top.equalTo(@(kStatesBarHeight));
            make.width.equalTo(@(60));
        }];
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@(-5));
            make.right.equalTo(self.searchButton.mas_left).offset(4);
            make.left.equalTo(@(30));
            make.top.equalTo(@(kStatesBarHeight + 5));
        }];
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return YES;
}

- (void)searchAction {
    if (_isCancel) {
         [self animationTableView:NO];
    } else {
        [self initinalView];
        if ([self.delegate respondsToSelector:@selector(beginSearch:)]) {
            [self.delegate beginSearch:nil];
        }
    }
}

- (void)setSearchResult:(NSArray *)searchResult {
    if (_searchResult != searchResult) {
        [self.resultTableView reloadData];
        [self animationTableView:YES];
    }
}

- (void)initinalView {
    if (self.resultTableView) {
        [self.container.view bringSubviewToFront:self.resultTableView];
        return;
    }
    _resultTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _resultTableView.dataSource = self;
    _resultTableView.delegate = self;
    [self.container.view addSubview:_resultTableView];
    [self.resultTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kNaviHeight));
        make.left.right.equalTo(@(0));
        make.height.mas_equalTo(0);
    }];
}

#pragma mark----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(pushNext:)]) {
        [self.delegate pushNext:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)animationTableView:(BOOL)show {
    if (show) {
        [self.resultTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(kScreenHeight - kNaviHeight);
        }];
    } else {
        [self.resultTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    [UIView animateWithDuration:.3 animations:^{
        [self.resultTableView.superview layoutIfNeeded];
    }];
}

@end
