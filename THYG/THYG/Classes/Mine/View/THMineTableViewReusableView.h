//
//  THMineTableViewReusableView.h
//  THYG
//
//  Created by C on 2019/8/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THMineTableViewReusableViewDelegate;

@interface THMineTableViewReusableView : UICollectionReusableView

@property (nonatomic, weak) id <THMineTableViewReusableViewDelegate> delegate;

@property (nonatomic, strong) NSArray *dataArray;

@end

@protocol THMineTableViewReusableViewDelegate <NSObject>



@end
