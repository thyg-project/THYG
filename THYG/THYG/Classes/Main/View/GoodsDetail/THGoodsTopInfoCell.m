//
//  THGoodsTopInfoCell.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsTopInfoCell.h"
#import "THGoosDetailModel.h"
#import "THButton.h"

@interface THGoodsTopInfoCell()


@property (nonatomic, strong) UILabel *productLabel, *priceLabel, *expressLabel, *saleNumLabel, *locationLabel;

@property (nonatomic, strong) THButton *favoriteButton;

@end

@implementation THGoodsTopInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initView];
    }
    return self;
}

- (void)initView {
    _productLabel = [UILabel new];
    _productLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _productLabel.numberOfLines = 2;
    _productLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel = [UILabel new];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _expressLabel = [UILabel new];
    _saleNumLabel = [UILabel new];
    _locationLabel = [UILabel new];
    _expressLabel.font = _saleNumLabel.font = _locationLabel.font = [UIFont systemFontOfSize:11];
    _expressLabel.textColor = _saleNumLabel.textColor = _locationLabel.textColor = [UIColor lightGrayColor];
    _saleNumLabel.textAlignment = NSTextAlignmentCenter;
    _locationLabel.textAlignment = NSTextAlignmentRight;
    _favoriteButton = [THButton buttonWithType:THButtonType_imageLeft];
    _favoriteButton.title = @"收藏";
    _favoriteButton.textColor = [UIColor grayColor];
    _favoriteButton.selectedTextColor = [UIColor redColor];
    _favoriteButton.font = [UIFont systemFontOfSize:15];
    _favoriteButton.image = [UIImage imageNamed:@"guanzhu"];
    _favoriteButton.selectedImage = [UIImage imageNamed:@"wodeguanzhu"];
    [_favoriteButton addTarget:self action:@selector(focusClick)];
    [self.contentView addSubview:_productLabel];
    [self.contentView addSubview:_priceLabel];
    [self.contentView addSubview:_expressLabel];
    [self.contentView addSubview:_saleNumLabel];
    [self.contentView addSubview:_locationLabel];
    [self.contentView addSubview:_favoriteButton];
    [self.favoriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(42);
        make.top.mas_equalTo(5);
        make.right.equalTo(@(-8));
        make.width.mas_equalTo(70);
    }];
    [self.productLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(12));
        make.right.equalTo(self.favoriteButton.mas_left).offset(-12);
        make.height.mas_equalTo(45);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.top.equalTo(self.productLabel.mas_bottom).offset(12);
        make.left.equalTo(self.productLabel);
    }];
    NSArray <UILabel *> *labels = @[self.expressLabel,self.saleNumLabel,self.locationLabel];
    [labels mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:8 tailSpacing:8];
    [labels mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(8);
        make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
    }];
}

- (void)setGoodsDetailModel:(THGoosDetailModel *)goodsDetailModel {
    _goodsDetailModel = goodsDetailModel;
    self.productLabel.text = _goodsDetailModel.goods_name?:@"快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递快递";
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2lf",_goodsDetailModel.shop_price];
    self.expressLabel.text = @"快递：缺少字段值";
    self.saleNumLabel.text = [NSString stringWithFormat:@"月销%@笔",_goodsDetailModel.sales_sum?:@"0"];
    self.locationLabel.text = @"缺少地点字段值";
    self.favoriteButton.selected = _goodsDetailModel.isCollected;
}

- (void)focusClick {
    self.favoriteButton.selected = !self.favoriteButton.selected;
    if (self.focusBtnAction) {
        self.focusBtnAction(self.favoriteButton.selected);
    }
    
}


@end
