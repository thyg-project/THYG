//
//  YGProvince.h
//  test
//
//  Created by C on 2018/12/10.
//  Copyright © 2018 C. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface YGDistrict : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@end


@interface YGCity : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray <YGDistrict *> *arealist;

@end

@interface YGProvince : NSObject

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray <YGCity *> *citylist;

@end

NS_ASSUME_NONNULL_END
