
//
//  GoodsInfoView.m
//  ChoseGoodsType
//
//  Created by 澜海利奥 on 2018/1/30.
//  Copyright © 2018年 江萧. All rights reserved.
//

#import "GoodsInfoView.h"
#import "GoodsModel.h"
#import "SizeAttributeModel.h"
@interface GoodsInfoView()
@property(nonatomic, strong)UIImageView *goodsImage;
@property(nonatomic, strong)UILabel *goodsTitleLabel;
@property(nonatomic, strong)UILabel *goodsCountLabel;
@property(nonatomic, strong)UILabel *goodsPriceLabel;
@end
@implementation GoodsInfoView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //商品图片
        _goodsImage = [[UIImageView alloc] init];
        _goodsImage.image = [UIImage imageNamed:@"1"];
        _goodsImage.contentMode =  UIViewContentModeScaleAspectFill;
        _goodsImage.clipsToBounds  = YES;
        [self addSubview:_goodsImage];
        
        //关闭按钮
        
        _closeButton = [THUIFactory buttonWithTitle:nil image:@"guanbi" selectedImage:@"guanbi" fontSize:16 textColor:nil bgColor:UIColor.whiteColor borderColor:nil radius:0 target:self action:nil];;
        [self addSubview:_closeButton];
        
        //标题
        _goodsTitleLabel = [THUIFactory labelWithText:@"标题" fontSize:0 tintColor:[UIColor blackColor]];
        [self addSubview:_goodsTitleLabel];
        
        
        //价格
        _goodsPriceLabel = [THUIFactory labelWithText:@"197" fontSize:14 tintColor:UIColor.redColor];
        [self addSubview:_goodsPriceLabel];
        
        //库存
        _goodsCountLabel = [THUIFactory labelWithText:@"库存" fontSize:14 tintColor:UIColor.grayColor];
        [self addSubview:_goodsCountLabel];
        
        //选择提示文字
        _promatLabel = [THUIFactory labelWithText:nil fontSize:0 tintColor:UIColor.grayColor];
        [self addSubview:_promatLabel];
        
        
    }
    return self;
}

- (void)initData:(GoodsModel *)model {
    _model = model;
    [_goodsImage setImage:[UIImage imageNamed:model.imageId]];
    [_goodsImage sd_setImageWithURL:[NSURL URLWithString:[@"" stringByAppendingString:model.imageId]] placeholderImage:nil];
    _goodsTitleLabel.text = model.title;
    _goodsCountLabel.text = [NSString stringWithFormat:@"库存：%@",model.totalStock];
    _goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@ ¥%@",model.price.minPrice,model.price.minOriginalPrice];
    NSMutableAttributedString *attritu = [[NSMutableAttributedString alloc]initWithString:_goodsPriceLabel.text];
    [attritu addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick), NSForegroundColorAttributeName: [UIColor lightGrayColor],NSBaselineOffsetAttributeName:@(0),
                             NSFontAttributeName: [UIFont systemFontOfSize:13]
                             } range:[_goodsPriceLabel.text rangeOfString:[NSString stringWithFormat:@"¥%@",model.price.minOriginalPrice]]];
    _goodsPriceLabel.attributedText = attritu;
}

//根据选择的属性组合刷新商品信息
- (void)resetData:(SizeAttributeModel *)sizeModel {
    //如果有图片就显示图片，没图片就显示默认图
    if (sizeModel.imageId.length>0) {
        [_goodsImage setImage:[UIImage imageNamed:sizeModel.imageId]];
    }else
        [_goodsImage setImage:[UIImage imageNamed:_model.imageId]];
    
    _goodsCountLabel.text = [NSString stringWithFormat:@"库存：%@",sizeModel.stock];
    _goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@ ¥%@",sizeModel.price,sizeModel.originalPrice];
    NSMutableAttributedString *attritu = [[NSMutableAttributedString alloc]initWithString:_goodsPriceLabel.text];
    [attritu addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick), NSForegroundColorAttributeName: [UIColor lightGrayColor],NSBaselineOffsetAttributeName:@(0),
                             NSFontAttributeName: [UIFont systemFontOfSize:13]
                             } range:[_goodsPriceLabel.text rangeOfString:[NSString stringWithFormat:@"¥%@",sizeModel.originalPrice]]];
    _goodsPriceLabel.attributedText = attritu;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
