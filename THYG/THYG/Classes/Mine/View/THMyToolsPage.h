//
//  THMyToolsPage.h
//  THYG
//
//  Created by C on 2019/10/25.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THToolsPageDelegate;

@interface THMyToolsPage : UIView

@property (nonatomic, weak) id <THToolsPageDelegate> delegate;

@end


@protocol THToolsPageDelegate <NSObject>

- (void)toolPage:(THMyToolsPage *)page didSelectedIndexPath:(NSIndexPath *)indexPath content:(NSString *)content;

@end

