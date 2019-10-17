//
//  THHomeHeaderItemCell.m
//  THYG
//
//  Created by Victory on 2018/3/15.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THHomeHeaderItemCell.h"
#import "THHomeHeaderItemModel.h"
@interface THHomeHeaderItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImgView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;

@end

@implementation THHomeHeaderItemCell

- (void)setItemModel:(THHomeHeaderItemModel *)itemModel {
	_itemModel = itemModel;
	self.iconImgView.image = [UIImage imageNamed:itemModel.image];
	self.nameLabel.text = itemModel.name;
}

- (void)setIsClassifyItem:(BOOL)isClassifyItem {
	_isClassifyItem = isClassifyItem;
	self.topLayout.constant = isClassifyItem? 0.0f : 12.0f;
}

- (void)setItem:(THCatogoryModel *)item {
    _item = item;
    
    [self.iconImgView setImageWithURL:[NSURL URLWithString:item.image] placeholder:[UIImage imageNamed:item.image]];
    self.nameLabel.text = item.title;
}


@end
