
//
//  THGoodsCommentHeaderView.m
//  THYG
//
//  Created by Mac on 2018/4/3.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsCommentHeaderView.h"

@interface THGoodsCommentHeaderView ()
@property (nonatomic, strong) UILabel *commentNumLabel;  // 评论总数
@property (nonatomic, strong) UILabel *goodReviewsLabel; // 好评率
@property (nonatomic, strong) UIView *lineView;
@end

@implementation THGoodsCommentHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.commentNumLabel];
        [self.contentView addSubview:self.goodReviewsLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)setCommentCount:(NSInteger)commentCount {
    _commentCount = commentCount;
    self.commentNumLabel.text = [NSString stringWithFormat:@"评价（%ld）", _commentCount];
}

- (void)setRatio:(NSString *)ratio {
    _ratio = ratio;
    self.goodReviewsLabel.text = [NSString stringWithFormat:@"好评度 %@", _ratio];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.goodReviewsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.offset(0);
        make.height.offset(0.8);
    }];
    
}

- (UILabel *)commentNumLabel {
    if (!_commentNumLabel) {
        _commentNumLabel = [THUIFactory labelWithText:@"评价（302）" fontSize:12 tintColor:GRAY_102];
    }
    return _commentNumLabel;
}

- (UILabel *)goodReviewsLabel {
    if (!_goodReviewsLabel) {
        _goodReviewsLabel = [THUIFactory labelWithText:@"好评度 99%" fontSize:12 tintColor:GRAY_51];
    }
    return _goodReviewsLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = LINECOLOR;
    }
    return _lineView;
}

@end
