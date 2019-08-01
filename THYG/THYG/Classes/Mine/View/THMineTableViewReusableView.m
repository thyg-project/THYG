//
//  THMineTableViewReusableView.m
//  THYG
//
//  Created by C on 2019/8/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THMineTableViewReusableView.h"
#import "THMineOrderHeaderCell.h"
#import "THMineSectionCell.h"
#import "THMineAdCell.h"

@interface THMineTableViewReusableView() {
    NSArray *_tableViewClass;
}

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation THMineTableViewReusableView

- (instancetype)init {
    if (self = [super init]) {
        _tableViewClass = @[@[@""],@[@"THMineShareQRCodeVC",@"THMineSubmitApplicationVC",@"THMineApplymentVC"],@[@"THCouponsCtl",@"THMineWalletVC"],@[@"THInvitationManageCtl",@"THMyCollectCtl",@"THMyCollectCtl",@"THTeCtl",@"THMyTaskCtl"]];
    }
    return self;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 3;
    } else if (section == 2) {
        return 2;
    } else if (section == 3) {
        return 5;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    if (indexPath.section == 0) {
        THMineOrderHeaderCell *orderCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineOrderHeaderCell.class)];
        
        orderCell.orderAction = ^(NSInteger index) {
//            THMineOrderManageVC *manageVc = [[THMineOrderManageVC alloc] init];
//            manageVc.menuViewStyle = WMMenuViewStyleLine;
//            manageVc.automaticallyCalculatesItemWidths = YES;
//            if (index != 3) {
//                manageVc.selectIndex = (index==0) ? 1 : (index == 1) ? 3 : (index == 2) ? 4 : 0;
//            } else {
//                manageVc.type = 1;
//                manageVc.selectIndex = 0;
//            }
//            [self.navigationController pushViewController:manageVc animated:YES];
        };
        
        cell = orderCell;
        
        
    } else if ((indexPath.section > 0 && indexPath.section < 4) || indexPath.section == 5) {
        THMineSectionCell *sectionCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineSectionCell.class)];
        sectionCell.dataDict = _dataArray[indexPath.section][indexPath.row];
        sectionCell.accessoryType = indexPath.section == 5 ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDisclosureIndicator;
        cell = sectionCell;
    } else {
        THMineAdCell *adCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(THMineAdCell.class)];
        cell = adCell;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

//- (void)pushWithIndexPath:(NSIndexPath *)indexPath {
//    Class class = NSClassFromString(_tableViewClass[indexPath.section][indexPath.row]);
//    if (class) {
//        UIViewController *controller = [[class alloc] init];
//        if (indexPath.section == 3 && (indexPath.row == 1 || indexPath.section == 2)) {
//            [controller setValue:@(indexPath.row == 2 ? MineGoodsTypeScanHistory : MineGoodsTypeMyAttention) forKey:@"type"];
//        }
//        [self.navigationController pushViewController:controller animated:YES];
//    }
//}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) return 67;
    if (indexPath.section == 4) return 150;
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}



@end
