//
//  THUserInfoEditCtl.m
//  THYG
//
//  Created by Colin on 2018/4/8.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THUserInfoEditCtl.h"
#import "THSelectTimeView.h"
#import "THSelectedCategoryView.h"
#import "THAlertTools.h"
#import "YGAuthTool.h"
#import "THUserInfoPresenter.h"

@interface THUserInfoEditCtl () <THSelectTimeViewDelegate, UITextFieldDelegate, THCategoryDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, THUserInfoProtocol> {
    UIImage *_selectedImage;
}
@property (weak, nonatomic) IBOutlet UIImageView *avatarImgView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *sexBtn;
@property (weak, nonatomic) IBOutlet UIButton *yearBtn;
@property (weak, nonatomic) IBOutlet UIButton *monthBtn;
@property (weak, nonatomic) IBOutlet UIButton *dayBtn;
@property (weak, nonatomic) IBOutlet UITextField *professionalField; // 职业
@property (weak, nonatomic) IBOutlet UIButton *categoryBtn;
@property (nonatomic, strong) THSelectTimeView *timeView;
@property (nonatomic, strong) THSelectedCategoryView *categoryView;
@property (assign, nonatomic) BOOL isSelectedSex;
@property (nonatomic, strong) UIImagePickerController *imagePickerController;
@property (nonatomic, copy) NSMutableDictionary *params;

@property (nonatomic, strong) NSMutableArray *dataSourceArray;
@property (nonatomic, strong) THUserInfoPresenter *presenter;

@end

@implementation THUserInfoEditCtl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"个人信息编辑";
    _presenter = [[THUserInfoPresenter alloc] initPresenterWithProtocol:self];
    self.avatarImgView.layer.masksToBounds = YES;
    self.avatarImgView.layer.cornerRadius = 40;
    self.nickNameLabel.delegate = self.professionalField.delegate = self;
}

- (UIImagePickerController *)imagePickerController {
    if (!_imagePickerController) {
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.allowsEditing = YES;
    }
    return _imagePickerController;
}

#pragma mark - 上传头像
- (IBAction)uploadImage:(id)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    kWeakSelf;
    UIAlertAction *takeCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![YGAuthTool cameraAuth]) {
            [THAlertTools alertTitle:@"没有权限" message:nil confirm:@"去开启" container:weakSelf confirmHandler:^{
                if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
                
            } cancel:@"取消" cancelHandler:NULL];
            return ;
        }
        weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        weakSelf.imagePickerController.modalPresentationStyle = UIModalPresentationFullScreen;
        weakSelf.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [weakSelf presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
    }];
    [alertController addAction:takeCamera];
    UIAlertAction *takePhoto = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [YGAuthTool requestPhotoAuth:^{
            weakSelf.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [weakSelf presentViewController:weakSelf.imagePickerController animated:YES completion:nil];
        }];
    }];
    [alertController addAction:takePhoto];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 选择性别
- (IBAction)sexBtnClick:(id)sender {
    _isSelectedSex = YES;
    self.categoryView.dataArray = @[@"男",@"女"];
    [self.categoryView showInView:self.view];
}

#pragma mark - 选择时间
- (IBAction)timeClick:(id)sender {
    [self.timeView showInView:self.view];
}

#pragma mark - 选择分类
- (IBAction)categoryBtnClick:(id)sender {
    _isSelectedSex = NO;
    self.categoryView.dataArray = self.dataSourceArray;
    [self.categoryView showInView:self.view];
}

#pragma mark - 确认修改
- (IBAction)okClick {
    [THHUDProgress show];
    [self.presenter updateUserInfo:self.params];
}

- (void)dismiss {
    
}

- (void)selectedItemWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day {
    [self.yearBtn setTitle:year forState:UIControlStateNormal];
    [self.monthBtn setTitle:month forState:UIControlStateNormal];
    [self.dayBtn setTitle:day forState:UIControlStateNormal];
    NSString *time = [[[year substringToIndex:year.length-1] stringByAppendingString:[month substringToIndex:month.length-1]] stringByAppendingString:[day substringToIndex:day.length-1]];
    self.params[@"birthday"] = @([time integerValue]);
}

- (void)dismiss:(THSelectedCategoryView *)view {
    
}

- (void)catogoryView:(THSelectedCategoryView *)category didSelectedItem:(NSString *)item {
    if (self.isSelectedSex) {
        [self.sexBtn setTitle:item forState:UIControlStateNormal];
        self.params[@"sex"] = [item isEqualToString:@"男"] ? @"1" : @"2";
    } else {
        [self.categoryBtn setTitle:item forState:UIControlStateNormal];
        self.params[@"favorite_cat"] = item;
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if (self.nickNameLabel == textField) {
        _params[@"nickname"] = textField.text;
    } else {
        _params[@"job"] = textField.text;
    }
    return YES;
}

#pragma mark - 懒加载
- (THSelectTimeView *)timeView {
    if (!_timeView) {
        _timeView = [THSelectTimeView new];
        _timeView.delegate = self;
    }
    return _timeView;
}

- (THSelectedCategoryView *)categoryView {
    if (!_categoryView) {
        _categoryView = [THSelectedCategoryView new];
        _categoryView.delegate = self;
    }
    return _categoryView;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return _params;
}

#pragma mark -- UIImagePickerController
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    _selectedImage = info[UIImagePickerControllerEditedImage];
    kWeakSelf;
    [picker dismissViewControllerAnimated:YES completion:^{
        NSString *fileName = [NSString stringWithFormat:@"%@.jpeg",@(arc4random() % 100000).stringValue];
        [weakSelf.presenter uploadImage:_selectedImage fileName:fileName];
    }];
}

#pragma mark --
- (void)updateUserInfoSuccess:(NSDictionary *)response {
    [THHUDProgress showMessage:response.message];
}

- (void)updateUserInfoFailed:(NSDictionary *)errorInfo {
    [THHUDProgress showMessage:errorInfo.message];
}

- (void)uploadImageFailed:(NSDictionary *)errorInfo {
    
}

- (void)updateAvaFailed:(NSDictionary *)errorInfo {
     [THHUDProgress showMessage:errorInfo.message];
}

- (void)updateAvaSuccess:(NSDictionary *)response {
    [THHUDProgress showMessage:response.message];
    
}

- (void)uploadImageSuccess:(NSDictionary *)response {
     self.avatarImgView.image = _selectedImage;
     [THHUDProgress showMessage:response.message];
}

@end
