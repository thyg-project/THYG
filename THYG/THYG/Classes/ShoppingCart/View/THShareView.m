//
//  THShareView.m
//  THYG
//
//  Created by Mac on 2018/6/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THShareView.h"
#import "THShareViewCell.h"
#import "THShareTool.h"

@implementation THShareObject



@end

@interface THShareView () <UICollectionViewDelegate, UICollectionViewDataSource, UIGestureRecognizerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *titleLabel;
//    所有标题
@property (nonatomic, copy) NSArray  *shareBtnTitleArray;
//    所有图片
@property (nonatomic, copy) NSArray  *shareBtnImageArray;
@end

@implementation THShareView

- (instancetype)initShareViewWithTitle:(NSArray *)titleArray andImageArry:(NSArray *)imageArray  {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = GRAY(0, 0.3);
        _shareBtnImageArray = imageArray;
        _shareBtnTitleArray = titleArray;
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.collectionView];
        [self.bgView addSubview:self.cancelBtn];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelClick)];
        tapGes.delegate = self;
        [self addGestureRecognizer:tapGes];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 44*2+kScreenWidth*0.5);
    self.titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 44);
    self.collectionView.frame = CGRectMake(0, 44, kScreenWidth, self.bgView.height-44*2);
    self.cancelBtn.frame = CGRectMake(0, self.bgView.height-44, kScreenWidth, 44);
    //    弹出
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.frame = CGRectMake(0, kScreenHeight - self.bgView.height, kScreenWidth, self.bgView.height);
    }];
    
}

- (void)cancelClick {
    [self dismiss];
}

- (void)dismiss {
    [UIView animateWithDuration:0.3 animations:^{
        self.bgView.top = kScreenHeight;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _shareBtnTitleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    THShareViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(THShareViewCell.class) forIndexPath:indexPath];
    cell.imageName = self.shareBtnImageArray[indexPath.item];
    cell.iconName = self.shareBtnTitleArray[indexPath.item];
    
    return cell;
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isDescendantOfView:self.bgView]) {
        return NO;
    }
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    if (!self.shareObject) {
        return;
    }
    BLOCK(self.selectItemBlock,indexPath.item);
    [self dismiss];
    UMSocialPlatformType type = UMSocialPlatformType_UnKnown;
    if (indexPath.item == 0) {
        type = UMSocialPlatformType_WechatSession;
    } else if (indexPath.item == 1) {
        type = UMSocialPlatformType_WechatTimeLine;
    } else if (indexPath.item == 2) {
        type = UMSocialPlatformType_QQ;
    } else if (indexPath.item == 3) {
        type = UMSocialPlatformType_Qzone;
    } else if (indexPath.item == 4) {
        type = UMSocialPlatformType_Sina;
    } else if (indexPath.item == 5) {
        if (!YGInfo.validString(self.shareObject.content)) {
            return;
        }
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.shareObject.content;
        [THHUDProgress showMsg:@"复制成功"];
        return;
    }
    if (type != UMSocialPlatformType_UnKnown) {
        [THShareTool shareGraphicToPlatformType:type ContentText:self.shareObject.content thumbnail:self.shareObject.thumbnail shareImage:self.shareObject.shareImage success:^(id result) {
            [THHUDProgress showMsg:@"分享成功"];
        } failure:^(NSError *error) {
            [THHUDProgress showMsg:@"分享失败"];
        }];
    }
    
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        CGFloat width = (kScreenWidth - 50) / 4;
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(width, width);
        layout.minimumLineSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
        layout.minimumInteritemSpacing = 5;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[THShareViewCell class] forCellWithReuseIdentifier:NSStringFromClass(THShareViewCell.class)];
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [THUIFactory labelWithText:@"分享到" fontSize:16 tintColor:GRAY_151];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:GRAY_51 forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _cancelBtn.backgroundColor = GRAY_COLOR(242);
        [_cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

@end
