//
//  THSelectTimeView.m
//  THYG
//
//  Created by Victory on 2018/5/25.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THSelectTimeView.h"
#define TEXT_COLOR [UIColor redColor] //RGB(26, 174, 135)

@interface THSelectTimeView () <UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate> {
    NSInteger yearIndex;
    NSInteger monthIndex;
    NSInteger dayIndex;
    UIView *topV;
}
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) NSMutableArray *yearArray;
@property (nonatomic, strong) NSMutableArray *monthArray;
@property (nonatomic, strong) NSMutableArray *dayArray;

@end

@implementation THSelectTimeView


- (void)showInView:(UIView *)inView {
    if (!inView) {
        inView = [UIApplication sharedApplication].delegate.window;
    }
    [UIView animateWithDuration:0.25 animations:^{
        topV.frame = CGRectMake(0, kScreenHeight - WIDTH(247), kScreenWidth, WIDTH(40));
        _pickerView.frame = CGRectMake(0, topV.bottom, kScreenWidth, WIDTH(207));
    }];
    [inView addSubview:self];
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = UIScreen.mainScreen.bounds;
        [self initDatas];
        [self setUp];
    }
    return self;
}

- (void)setUp {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    
    topV = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, WIDTH(40))];
    topV.backgroundColor = RGB(242, 242, 242);
    [self addSubview:topV];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame = CGRectMake(0, 0, WIDTH(100), WIDTH(40));
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [topV addSubview:cancelBtn];
    
    UIButton *yesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    yesBtn.frame = CGRectMake(kScreenWidth - WIDTH(100), 0, WIDTH(100), WIDTH(40));
    [yesBtn setTitle:@"完成" forState:UIControlStateNormal];
    [yesBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [yesBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [yesBtn addTarget:self action:@selector(okClick) forControlEvents:UIControlEventTouchUpInside];
    [topV addSubview:yesBtn];
    
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, topV.bottom, kScreenWidth, WIDTH(207))];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    _pickerView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_pickerView];
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents *comp = [calendar components: unitFlags fromDate:[NSDate date]];
    
    yearIndex = [self.yearArray indexOfObject:[NSString stringWithFormat:@"%ld年", comp.year]];
    monthIndex = [self.monthArray indexOfObject:[NSString stringWithFormat:@"%02ld月", comp.month]];
    dayIndex = [self.dayArray indexOfObject:[NSString stringWithFormat:@"%02ld日", comp.day]];
    
    [_pickerView selectRow:yearIndex inComponent:0 animated:YES];
    [_pickerView selectRow:monthIndex inComponent:1 animated:YES];
    [_pickerView selectRow:dayIndex inComponent:2 animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self pickerView:_pickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:_pickerView didSelectRow:monthIndex inComponent:1];
        [self pickerView:_pickerView didSelectRow:dayIndex inComponent:2];
    });
}

#pragma mark -UIPickerView
#pragma mark UIPickerView的数据源
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.yearArray.count;
        
    } else if(component == 1) {
        return self.monthArray.count;
        
    } else {
        switch (monthIndex + 1) {
                
            case 1:
            case 3:
            case 5:
            case 7:
            case 8:
            case 10:
            case 12: return 31;
                
            case 4:
            case 6:
            case 9:
            case 11: return 30;
                
            default: return 28;
        }
    }
}

- (void)okClick {
    if ([self.delegate respondsToSelector:@selector(selectedItemWithYear:month:day:)]) {
        [self.delegate selectedItemWithYear:self.yearArray[yearIndex] month:self.monthArray[monthIndex] day:self.dayArray[dayIndex]];
    }
    [self remove];
}

- (void)cancelClick {
    [self remove];
}

- (void)remove {
    [UIView animateWithDuration:0.25 animations:^{
        topV.frame = CGRectMake(0, kScreenHeight,  kScreenWidth, WIDTH(40));
        _pickerView.frame = CGRectMake(0, topV.bottom, kScreenWidth, WIDTH(207));
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if ([self.delegate respondsToSelector:@selector(dismiss)]) {
            [self.delegate dismiss];
        }
    }];
}
#pragma mark -UIPickerView的代理

// 滚动UIPickerView就会调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        yearIndex = row;
        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        label.textColor = TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
    } else if (component == 1) {
        monthIndex = row;
        [pickerView reloadComponent:2];
        if (monthIndex + 1 == 4 || monthIndex + 1 == 6 || monthIndex + 1 == 9 || monthIndex + 1 == 11) {
            if (dayIndex + 1 == 31) {
                dayIndex--;
            }
        } else if (monthIndex + 1 == 2) {
            if (dayIndex + 1 > 28) {
                dayIndex = 27;
            }
        }
        [pickerView selectRow:dayIndex inComponent:2 animated:YES];
        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        label.textColor = TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
        label = (UILabel *)[pickerView viewForRow:dayIndex forComponent:2];
        label.textColor = TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
    } else {
        dayIndex = row;
        UILabel *label = (UILabel *)[pickerView viewForRow:row forComponent:component];
        label.textColor = TEXT_COLOR;
        label.font = [UIFont systemFontOfSize:16];
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    //设置文字的属性
    UILabel *genderLabel = [[UILabel alloc] init];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    genderLabel.textColor = RGB(151, 151, 151);
    genderLabel.font = [UIFont systemFontOfSize:14];
    if (component == 0) {
        genderLabel.text = self.yearArray[row];
    } else if (component == 1) {
        genderLabel.text = self.monthArray[row];
    } else {
        genderLabel.text = self.dayArray[row];
    }
    return genderLabel;
}

- (void)initDatas {
    _dayArray = [NSMutableArray new];
    for (int day = 1; day <= 31; day++) {
        NSString *str = [NSString stringWithFormat:@"%02d日", day];
        [_dayArray addObject:str];
    }
    _monthArray = [NSMutableArray new];
    for (int month = 1; month <= 12; month++) {
        NSString *str = [NSString stringWithFormat:@"%02d月", month];
        [_monthArray addObject:str];
    }
    _yearArray = [NSMutableArray new];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    for (NSInteger year = comp.year - 100; year <= comp.year; year++) {
        NSString *str = [NSString stringWithFormat:@"%ld年", year];
        [_yearArray addObject:str];
    }
}


@end
