//
//  THTeHuiCell.m
//  THYG
//
//  Created by Mac on 2018/5/18.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THTeHuiCell.h"
#import "SDWeiXinPhotoContainerView.h"
#import "THTeHuiModel.h"

const CGFloat contentLblFontSize = 15;
CGFloat maxContentLblHeight = 0; // 根据具体font而定

@interface THTeHuiCell () {
    UILabel *_nameLabel;
    UILabel *_contentLabel;
    UILabel *_timeLabel;
    UIButton *_moreButton;
    UIView   *_buttomView;
    UIView *_groupImgView;
    UIView *_buttomToolView;
    UIImageView *_avatarImgView;
    UIImageView *_iconImgView;
    UILabel *_buttonSubLabel;
    SDWeiXinPhotoContainerView *_picContainerView;
}
@property (nonatomic, strong) NSMutableArray <UIButton *> *buttonArr;

@end

@implementation THTeHuiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    if (!_avatarImgView) {
        _avatarImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang"]];
    }
    
    if (!_nameLabel) {
//        _nameLabel = [UILabel labelWithText:@"lalalala" fontSize:[UIFont systemFontOfSize:16] color:GRAY_51];
    }
    
    if (!_timeLabel) {
//        _timeLabel = [UILabel labelWithText:@"hehehehehe" fontSize:[UIFont systemFontOfSize:12] color:GRAY_151];
    }
    
    if (!_contentLabel) {
//        _contentLabel = [UILabel labelWithText:@"aldlasdladladladlaldalsaldaldaldladsladlbsdfhahfasdhfahfahfhasdfhafhahdfahfhashdfhahfahfhashdfahdfhashdfahsdfhasfdhashdfahf" fontSize:[UIFont systemFontOfSize:16] color:GRAY_51];
        _contentLabel.numberOfLines = 0;
        if (maxContentLblHeight == 0) {
            maxContentLblHeight = _contentLabel.font.lineHeight * 3;
        }
    }
    
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setTitle:@"查看全文" forState:UIControlStateNormal];
        [_moreButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
//        _moreButton.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    
//    if (!_groupImgView) {
//        _groupImgView = [[UIView alloc] init];
//        _groupImgView.backgroundColor = RANDOMCOLOR;
//    }
    
    if (!_picContainerView) {
        _picContainerView = [SDWeiXinPhotoContainerView new];
    }
    
    if (!_buttomView) {
        _buttomView = [[UIView alloc] init];
        _buttomView.backgroundColor = BGColor;
        
        _iconImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chanpintu"]];
        [_buttomView addSubview:_iconImgView];
        
//        _buttonSubLabel = [UILabel labelWithText:@"佳宝怀旧小吃小吃小吃小吃小吃小吃小吃小吃" fontSize:[UIFont systemFontOfSize:14] color:GRAY_151];
        _buttonSubLabel.numberOfLines = 2;
        [_buttomView addSubview:_buttonSubLabel];
        
    }
    
    if (!_buttomToolView) {
        _buttomToolView = [[UIView alloc] init];
        _buttomToolView.backgroundColor  = [UIColor whiteColor];
        NSArray *titles = @[@"0",@"0",@"0"];
        NSArray *images = @[@"fenxiang",@"pinglun",@"dianzan"];
        for (int i = 0; i < titles.count; i++) {
            UIButton *btn = [UIButton new];
            [_buttonArr addObject:btn];
            btn.tag = i + kScreenHeight;
            [btn setTitle:titles[i] forState:UIControlStateNormal];
            [btn setTitleColor:GRAY_51 forState:UIControlStateNormal];
//            btn.titleLabel.font = [UIFont systemFontOfSize:16];
            [btn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
            if (i == 2) {
                [btn setImage:
                 [UIImage imageNamed:@"dianlezan"] forState:UIControlStateSelected];
            }
            [btn addTarget:self action:@selector(buttonCLick:) forControlEvents:UIControlEventTouchUpInside];
            
            btn.frame = CGRectMake((56+38)*i, 0, 56, 42);
            [_buttomToolView addSubview:btn];
            [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleLeft imageTitleSpace:10];
        }
    }
    
    NSArray *views = @[_avatarImgView, _nameLabel, _timeLabel, _contentLabel, _moreButton, _picContainerView, _buttomView, _buttomToolView];
    
    
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    
}

- (void)setTeModel:(THTeHuiModel *)teModel {
    _teModel = teModel;
    [_avatarImgView sd_setImageWithURL:[NSURL URLWithString:_teModel.head_pic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!error) {
            _avatarImgView.image = [image circleImage];
        } else {
            _avatarImgView.image = [UIImage imageNamed:@"touxiang"];
        }
    }];
    
    _nameLabel.text = _teModel.username;
    _timeLabel.text = _teModel.add_time;
    _contentLabel.text = _teModel.content;
    _picContainerView.picPathStringsArray = _teModel.img;
    [_iconImgView sd_setImageWithURL:[NSURL URLWithString:_teModel.original_img] placeholderImage:[UIImage imageNamed:@"chanpintu"]];
    _buttonSubLabel.text = _teModel.goods_name;

    [_buttonArr[0] setTitle:[NSString stringWithFormat:@"%ld", _teModel.forward_num] forState:UIControlStateNormal];
    [_buttonArr[1] setTitle:[NSString stringWithFormat:@"%ld", _teModel.comment_num] forState:UIControlStateNormal];
    [_buttonArr[2] setTitle:[NSString stringWithFormat:@"%ld", _teModel.zan_num] forState:UIControlStateNormal];
    
   

}

#pragma mark - 底部按钮点击
- (void)buttonCLick:(UIButton *)sender {
    NSInteger tag = sender.tag - kScreenHeight;
    if (tag == 2) {
        sender.selected = !sender.selected;
        NSInteger count = [sender.currentTitle integerValue];
        [sender setTitle:[NSString stringWithFormat:@"%ld",sender.selected ? count+1 : count-1] forState:UIControlStateNormal];
    }
}


- (void)moreButtonClicked {
}

- (NSMutableArray<UIButton *> *)buttonArr {
    if (!_buttonArr) {
        _buttonArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _buttonArr;
}

@end
