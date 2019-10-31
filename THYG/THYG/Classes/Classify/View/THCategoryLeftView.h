//
//  THCategoryLeftView.h
//  THYG
//
//  Created by C on 2019/10/30.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol THCategoryLeftViewDelegate;

@interface THCategoryLeftView : UIView

@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, weak) id <THCategoryLeftViewDelegate>delegate;

@end

@protocol THCategoryLeftViewDelegate <NSObject>

- (void)categoryLeftView:(THCategoryLeftView *)leftView didSelectedIndex:(NSIndexPath *)indexPath;

@end
