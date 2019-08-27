//
//  YGAreaPickerView.m
//  test
//
//  Created by C on 2018/12/10.
//  Copyright © 2018 C. All rights reserved.
//

#import "YGAreaPickerView.h"


@interface YGAreaPickerView() <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray <YGProvince *>*_dataSource;
    UIView *_containerView;
    UIView *_toolBar;
}

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, assign) NSInteger selectedPro, selectedCity, selectedArea;

@end

@implementation YGAreaPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadJson];
        [self setup];
    }
    return self;
}

- (void)setup {
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _containerView = [UIView new];
    _containerView.alpha = 0;
    _containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.5];
    [_containerView addSubview:self];
    [_containerView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)]];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(_containerView);
        make.height.mas_equalTo(0);
    }];
    [self addSubview:_pickerView];
    [self loadToolBar];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(@(30));
    }];
    [_pickerView reloadAllComponents];
}

- (void)loadToolBar {
    _toolBar = [UIView new];
    _toolBar.backgroundColor = [UIColor whiteColor];
    [self addSubview:_toolBar];
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [_toolBar addSubview:cancel];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.textAlignment = NSTextAlignmentLeft;
    [cancel setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:11];
    [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    UIButton *confrim = [UIButton buttonWithType:UIButtonTypeCustom];
    [_toolBar addSubview:confrim];
    [confrim setTitle:@"确定" forState:UIControlStateNormal];
    confrim.titleLabel.textAlignment = NSTextAlignmentRight;
    confrim.titleLabel.font = [UIFont systemFontOfSize:11];
    [confrim setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [confrim addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [_toolBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_toolBar);
        make.left.equalTo(@(15));
        make.width.mas_equalTo(50);
    }];
    [confrim mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(_toolBar);
        make.right.equalTo(@(-15));
        make.width.mas_equalTo(50);
    }];
}

- (void)loadJson {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"BRCity" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    _dataSource = [NSArray modelArrayWithClass:[YGProvince class] json:d];
}

#pragma mark ----
//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
//    return [UIScreen mainScreen].bounds.size.width / 3;
//}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds) / 3, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15.0];
    label.textColor = UIColor.blueColor;
    NSString *title = nil;
    switch (component) {
        case 0: {
            title = _dataSource[row].name;
        }
            break;
            
        case 1: {
            title = _dataSource[self.selectedPro].citylist[row].name;
        }
            break;
        case 2: {
            NSArray <YGDistrict *> *list = _dataSource[self.selectedPro].citylist[self.selectedCity].arealist;
            title = list[row].name;
        }
            break;
    }
    label.text = title;
    return label;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger number = 0;
    switch (component) {
        case 0: {
            number = _dataSource.count;
        }
            break;
            
        case 1: {
            number = _dataSource[self.selectedPro].citylist.count;
        }
            break;
        case 2: {
            number = _dataSource[self.selectedPro].citylist[self.selectedCity].arealist.count;
        }
            break;
    }
    NSLog(@"=========number is %ld=====",number);
    return number;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component) {
        case 0: {
            self.selectedPro = row;
            self.selectedCity = 0;
            self.selectedArea = 0;
             [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:0 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1: {
            self.selectedCity = row;
            self.selectedArea = 0;
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
        case 2: {
            self.selectedArea = row;
        }
            break;
    }
}

- (void)showInView:(UIView *)inView {
    if (_containerView.superview) {
        [UIView animateWithDuration:.15 animations:^{
            _containerView.alpha = 1;
        } completion:^(BOOL finished) {
            [self mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo(@(250));
            }];
            [UIView animateWithDuration:.3 animations:^{
                [_containerView layoutIfNeeded];
            }];
        }];
        return;
    }
    if (!inView) {
        inView = [UIApplication sharedApplication].delegate.window;
    }
    [inView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(inView);
        make.height.mas_equalTo(CGRectGetHeight(inView.frame));
        make.top.equalTo(@(0));
    }];
    [UIView animateWithDuration:.15 animations:^{
        _containerView.alpha = 1;
    } completion:^(BOOL finished) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(250);
        }];
        [UIView animateWithDuration:.3 animations:^{
            [_containerView layoutIfNeeded];
        }];
    }];
}

- (void)tap {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0));
    }];
    [UIView animateWithDuration:.2 animations:^{
        [_containerView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:.2 animations:^{
           _containerView.alpha = 0;
        }];
    }];
}

- (UIView *)container {
    return _containerView;
}

- (void)cancelAction {
    [self tap];
}

- (void)confirmAction {
    if ([self.delegate respondsToSelector:@selector(didSelectedPro:city:area:)]) {
        YGProvince *pro = _dataSource[self.selectedPro];
        [self.delegate didSelectedPro:pro city:pro.citylist[self.selectedCity] area:pro.citylist[self.selectedCity].arealist[self.selectedArea]];
    }
    [self tap];
}

@end
