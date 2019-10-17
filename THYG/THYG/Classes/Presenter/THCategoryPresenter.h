//
//  THCategoryPresenter.h
//  THYG
//
//  Created by C on 2019/7/14.
//  Copyright © 2019 THYG. All rights reserved.
//

#import "THBasePresenter.h"
#import "THCategoryProtocol.h"


@interface THCategoryPresenter : THBasePresenter

- (void)loadLocalizedData;

- (void)searchDataWithContent:(NSString *)content;


- (void)getCategory;

@end


