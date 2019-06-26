
//
//  ChoosTypeTableViewCell.m
//  MeiXiangDao_iOS
//
//  Created by 澜海利奥 on 2017/9/26.
//  Copyright © 2017年 江萧. All rights reserved.
//

#import "ChoosTypeTableViewCell.h"
#import "Header.h"
@interface ChoosTypeTableViewCell()
{
    //类型名
    UILabel *typeNameLabel;
    UIView *typeView;//装载所有属性button的视图
}
@end
@implementation ChoosTypeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];

        typeNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
        typeNameLabel.textColor = [UIColor blackColor];
        typeNameLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:typeNameLabel];
        
        
        [self addSubview:typeView];
    }
    return self;
}
-(float)setData:(GoodsTypeModel *)model
{
    _model = model;
    typeNameLabel.text = model.typeName;
    return [self initTypeView];//每次刷新重绘
}
-(float)initTypeView
{
    //循环删除typeView所有子视图，防止cell重用产生错乱
    while ([typeView.subviews lastObject] != nil)
    {
        [[typeView.subviews lastObject] removeFromSuperview];
    }
    float upX = 10;
    float upY = 0;
    for (int i = 0; i<_model.typeArray.count; i++) {
        UIButton *btn= nil;
        NSDictionary *dic = [NSDictionary dictionaryWithObject:btn.titleLabel.font forKey:NSFontAttributeName];
        CGSize size = [_model.typeArray[i] sizeWithAttributes:dic];
        //NSLog(@"%f",size.height);
        //20是左右边距各10，size.width+30是按钮宽度，间隔为10，通过计算x的位置判断是否换行显示按钮
        if ( upX > (self.frame.size.width-20 -size.width-40)) {
            upX = 10;
            upY += 30;
        }
        btn.frame = CGRectMake(upX, upY, size.width+30,24);
       
        [typeView addSubview:btn];
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(touchbtn:) forControlEvents:UIControlEventTouchUpInside];
        upX+=size.width+40;

        if (_model.selectIndex == i) {
            btn.selected = YES;
            
        }
    }

    upY +=30;
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(0, upY+10, self.frame.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    [typeView addSubview:line];

    
    return upY+11+40;

}
-(void)touchbtn:(UIButton *)btn
{
    
    if (btn.selected == NO) {
        _model.selectIndex = (int)btn.tag-100;
    }else
    {
        //取消选中
        _model.selectIndex = -1;
    }
    if (self.selectButton) {
        self.selectButton(_model.selectIndex);
    }
    for (int i = 0; i<_model.typeArray.count; i++) {
        UIButton *button =(UIButton *)[self viewWithTag:100+i];
        button.selected = NO;
        
        //根据seletIndex 确定用户当前点了那个按钮
        if (_model.selectIndex == i) {
            button.selected = YES;
            
        }
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
