//
//  THCategoryLeftView.m
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THCategoryLeftView.h"


@interface THCategoryLeftTableViewCell : UITableViewCell {
    UIView *_identifierView;
    UILabel *_titleLabel;
}

@property (nonatomic, assign) BOOL p_selected;
@end

@implementation THCategoryLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setup];
    }
    return self;
}

- (void)setup {
    _identifierView = [UIView new];
    _identifierView.backgroundColor = UIColorHex(0xD62326);
    [self addSubview:_identifierView];
    _titleLabel = [UILabel new];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:16];
    [self addSubview:_titleLabel];
    [_identifierView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(4, 20));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(@(0));
        make.left.equalTo(_identifierView.mas_right);
    }];
}

- (void)setP_selected:(BOOL)p_selected {
    _p_selected = p_selected;
    _identifierView.hidden = !_p_selected;
    if (_p_selected) {
        _titleLabel.textColor = UIColorHex(0xD62326);
        self.backgroundColor = UIColorHex(0xf7f8f9);
    } else {
        _titleLabel.textColor = UIColorHex(0x717171);
        self.backgroundColor = UIColorHex(0xffffff);
    }
}

- (void)setContent:(NSString *)content {
    _titleLabel.text = content;
}


@end




@interface THCategoryLeftView() <UITableViewDelegate, UITableViewDataSource> {
    UITableView *_tableView;
    NSInteger _selectedIndex;
}

@end

@implementation THCategoryLeftView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles;
    [_tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [_tableView reloadData];
    if ([self.delegate respondsToSelector:@selector(categoryLeftView:didSelectedIndex:)]) {
        [self.delegate categoryLeftView:self didSelectedIndex:indexPath];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    THCategoryLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[THCategoryLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == _selectedIndex) {
        cell.p_selected = YES;
    } else {
        cell.p_selected = NO;
    }
    [cell setContent:_titles[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}






@end
