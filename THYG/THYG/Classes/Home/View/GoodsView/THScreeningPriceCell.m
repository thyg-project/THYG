//
//  THScreeningPriceCell.m
//  THYG
//
//  Created by Colin on 2018/4/4.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THScreeningPriceCell.h"

@interface THScreeningPriceCell () <UITextFieldDelegate> {
    __weak IBOutlet UITextField *leftField;
    __weak IBOutlet UITextField *rightField;
}

@end

@implementation THScreeningPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    leftField.delegate = self;
    rightField.delegate = self;
}

- (void)setResetValue:(BOOL)resetValue {
    _resetValue = resetValue;
    if (_resetValue) {
        leftField.text = rightField.text = @"";
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    BLOCK(self.siftPriceBlock,leftField.text,rightField.text);
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    BLOCK(self.siftPriceBlock,leftField.text,rightField.text);
    return YES;
}

@end
