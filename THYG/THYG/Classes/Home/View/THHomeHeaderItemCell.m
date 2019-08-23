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

- (void)setItemDict:(NSDictionary *)itemDict {
	_itemDict = itemDict;
    [self.iconImgView setImageWithURL:[NSURL URLWithString:itemDict[@"image"]] placeholder:[UIImage imageNamed:itemDict[@"image"]]];
    if ([itemDict.allKeys containsObject:@"mobile_name"]) {
        self.nameLabel.text = itemDict[@"mobile_name"];
    } else {
        self.nameLabel.text = itemDict[@"title"];
    }
}


@end
