//
//  THTeTableViewCell.h
//  THYG
//
//  Created by C on 2019/11/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface THTeTableViewCell : UITableViewCell  {
@public
    UIImageView *_leftImageView;
    
    UILabel *_titleLabel;
    
    UILabel *_desLabel;
    
    UIView *_containerView;
}

- (void)setup;

@end


@interface THTeDBTableViewCell : THTeTableViewCell {
@public
    UIProgressView *_progressView;
    UIButton *_buyButton;
}

@end


@interface THTePTableViewCell : THTeTableViewCell {
    @public
    UILabel *_pLabel;
}

@end
