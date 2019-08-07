//
//  THGoodsVC.m
//  THYG
//
//  Created by Mac on 2018/4/2.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THGoodsVC.h"
#import "THGoodsHeaderView.h"
#import "THGoodsTopInfoCell.h"
#import "THGoodsCommentCell.h"
#import "THGoodsSpecificationsCell.h"
#import "THGoodsCommentHeaderView.h"
//选择规格
#import "ChoseGoodsTypeAlert.h"
#import "SizeAttributeModel.h"
#import "GoodsTypeModel.h"
#import "GoodsModel.h"


@interface THGoodsVC () <UITableViewDataSource, UITableViewDelegate> {
    NSUInteger _commentCount;  // 总评论数量
    NSUInteger _sectionCount; // 分组数量
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *banners;
@end

@implementation THGoodsVC{
    GoodsModel* model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    model = [[GoodsModel alloc] init];
}


- (void)setDetailModel:(THGoosDetailModel *)detailModel {
    _detailModel = detailModel;
    model.goodsNo = self.detailModel.goods_id;
    model.title = self.detailModel.goods_name;
}

- (void)setGoodsSpecModel:(THGoodsSpecModel *)goodsSpecModel {
    _goodsSpecModel = goodsSpecModel;
    if (!_goodsSpecModel.filter_spec.count) return;
    
    NSMutableArray * itemsListArr = [NSMutableArray arrayWithCapacity:0];
    for (THFilterSpecModel *filterModel in self.goodsSpecModel.filter_spec) {
        GoodsTypeModel *tpModel = [[GoodsTypeModel alloc] init];
        tpModel.typeName = filterModel.name;
        NSMutableArray *nameArr = [NSMutableArray arrayWithCapacity:0];
        int index = 0;
        for (THItemSpecModel *itemM in filterModel.spec) {
            if ([self.goodsSpecModel.defaultSpec.key rangeOfString:itemM.spec_item_id].location != NSNotFound) {
                tpModel.selectIndex = index;
            }
            index++;
            [nameArr addObject:itemM.item];
        }
        tpModel.typeArray = nameArr;
        [itemsListArr addObject:tpModel];
    }
    model.itemsList = itemsListArr;
    
    model.sizeAttribute = [[NSMutableArray alloc] init];
    NSMutableArray *valueArr = @[].mutableCopy;
    for (THSpecDefaultModel *model in self.goodsSpecModel.spec_goods_price) {
        NSMutableString *mutStr = [[NSMutableString alloc] init];
        for (THFilterSpecModel *filterModel in self.goodsSpecModel.filter_spec) {
            for (THItemSpecModel *itemM in filterModel.spec) {
                if ([model.key rangeOfString:itemM.spec_item_id].location != NSNotFound) {
                    [mutStr appendFormat:@"%@、",itemM.item];
                }
            }
        }
        if (!mutStr.length) {
            continue;
        }
        [valueArr addObject:[mutStr substringToIndex:mutStr.length-1]];
    }
    
    for (int i = 0; i < valueArr.count; i++) {
        SizeAttributeModel *type = [[SizeAttributeModel alloc] init];
        type.price = self.goodsSpecModel.spec_goods_price[i].price;
        type.originalPrice = self.goodsSpecModel.spec_goods_price[i].price;
        type.stock = self.goodsSpecModel.spec_goods_price[i].store_count;
        type.goodsNo = model.goodsNo;
        type.value = valueArr[i];
        type.sizeid = [NSString stringWithFormat:@"%ld",self.goodsSpecModel.spec_goods_price[i].item_id];
        type.imageId = self.detailModel.original_img;
        [model.sizeAttribute addObject:type];
    }
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
    [self autoLayoutSizeContentView:self.tableView];
}

- (void)setBannerArr:(NSArray<THGoodsDetailBannerModel *> *)bannerArr {
    _bannerArr = bannerArr;
    for (THGoodsDetailBannerModel *model in _bannerArr) {
        if (![model.image_url containsString:@"http://"]) {
            model.image_url = [@"http://th1818.bingogd.com" stringByAppendingString:model.image_url];
        }
        [self.banners addObject:model.image_url];
    }
    [self.tableView reloadData];
}

- (void)setCommentArr:(NSMutableArray<THGoodsCommentModel *> *)commentArr {
    _commentArr = commentArr;
    _commentCount = _commentArr.count;
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (int i = 0; i < _commentArr.count; i++) {
        if (i > 2) {
            [indexSet addIndex:i];
        }
    }
    [_commentArr removeObjectsAtIndexes:indexSet];
    [self.tableView reloadData];
}

- (void)setCommentRatio:(NSString *)commentRatio {
    _commentRatio = commentRatio;
    [self.tableView reloadData];
}

#pragma mark - 取消 / 收藏商品
- (void)collectGoods:(BOOL)collect {

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (_commentArr.count && _goodsSpecModel.filter_spec.count) {
        return 3;
        
    } else if (!_commentArr.count && !_goodsSpecModel.filter_spec.count) {
        return 1;
        
    } else {
        return 2;
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return _commentArr.count;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = nil;
    if (indexPath.section == 0) {
        cell = [self goodsInfoCellWithTableView:tableView indexPath:indexPath];
    } else if (indexPath.section == 1) {
        if (_goodsSpecModel.filter_spec.count) {
            cell = [self goodsSpecificationsCellWithTableView:tableView indexPath:indexPath];
        } else {
            cell = [self commonCellWithTableView:tableView indexPath:indexPath];
        }
    } else {
        cell = [self commonCellWithTableView:tableView indexPath:indexPath];
    }
    return cell;
}

- (UITableViewCell *)goodsInfoCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THGoodsTopInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THGoodsTopInfoCell.class)];
    infoCell.goodsDetailModel = self.detailModel;
    kWeakSelf;
    infoCell.focusBtnAction = ^(BOOL isSelected) {
        if (!weakSelf.detailModel) {
            return ;
        }
        [weakSelf collectGoods:isSelected];
    };
    return infoCell;
}

- (UITableViewCell *)commonCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THGoodsCommentCell *commentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THGoodsCommentCell.class)];
    commentCell.commentModel = _commentArr[indexPath.row];
    return commentCell;
}

- (UITableViewCell *)goodsSpecificationsCellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    THGoodsSpecificationsCell *specCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THGoodsSpecificationsCell.class)];
    specCell.defaultSpec = self.goodsSpecModel.defaultSpec.default_str;
    kWeakSelf;
    kWeakObject(specCell)
    specCell.selectSpecBtnBlock = ^{
        ChoseGoodsTypeAlert *_alert = [[ChoseGoodsTypeAlert alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) andHeight:0];
        _alert.alpha = 0;
        [[UIApplication sharedApplication].delegate.window addSubview:_alert];
        
        _alert.selectSize = ^(SizeAttributeModel *sizeModel) {
            //sizeModel 选择的属性模型
            
            weakObject.defaultSpec = sizeModel.value;
            
            !weakSelf.specBlock?:weakSelf.specBlock(sizeModel.sizeid, sizeModel.count);
            
        };
        [_alert initData:model];
        [_alert showView];
        
    };
    return specCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = nil;
    if (section == 0) {
        THGoodsHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(THGoodsHeaderView.class)];
        headerView.bannerImageArray = self.banners;
        view = headerView;
        
    } else if (section == 2 || (!_goodsSpecModel.filter_spec.count && _commentArr.count && section == 1)) {
        THGoodsCommentHeaderView *commentHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(THGoodsCommentHeaderView.class)];
        commentHeaderView.commentCount = _commentCount;
        commentHeaderView.ratio = _commentRatio;
        view = commentHeaderView;
        
    }
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!section) {
        return kScreenWidth;
    } else if (section == 2) {
        return 44;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 44;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.section) {
        return 112;
    } else if (indexPath.section == 2) {
//        THGoodsCommentModel *model = _commentArr[indexPath.row];
        return 80;
    }
    return 44;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-kTabBarHeight-kNaviHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView registerClass:THGoodsHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(THGoodsHeaderView.class)];
        
        [_tableView registerClass:THGoodsCommentHeaderView.class forHeaderFooterViewReuseIdentifier:NSStringFromClass(THGoodsCommentHeaderView.class)];
        
        [_tableView registerNib:[UINib nibWithNibName:@"THGoodsTopInfoCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THGoodsTopInfoCell.class)];
        
        [_tableView registerNib:[UINib nibWithNibName:@"THGoodsSpecificationsCell" bundle:nil] forCellReuseIdentifier:NSStringFromClass(THGoodsSpecificationsCell.class)];
        
        [_tableView registerClass:THGoodsCommentCell.class forCellReuseIdentifier:NSStringFromClass(THGoodsCommentCell.class)];
        
    }
    return _tableView;
}

- (NSMutableArray *)banners {
    if (!_banners) {
        _banners = [NSMutableArray arrayWithCapacity:0];
    }
    return _banners;
}

@end
