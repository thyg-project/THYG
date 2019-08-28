//
//  THScanQRCodeVC.h
//  THYG
//
//  Created by Mac on 2018/4/1.
//  Copyright © 2018年 THYG. All rights reserved.
//

#import "THBaseVC.h"

typedef NS_ENUM(NSInteger, THScanType) {
    THScanType_QR               = 0,
    THScanType_Bar
};

@protocol THScanResultDelegate;


@interface THScanQRCodeVC : THBaseVC

@property (nonatomic, weak) id <THScanResultDelegate> delegate;

@end

@protocol THScanResultDelegate <NSObject>

- (void)scanResult:(NSString *)url scanType:(THScanType)scanType;

@end
