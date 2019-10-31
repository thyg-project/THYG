//
//  THCardEmptyView.h
//  THYG
//
//  Created by C on 2019/10/29.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface THCardEmptyView : UIView

@property (nonatomic, copy) void (^(toOther))(void);

@end


