//
//  THNetworkCondition.h
//  THYG
//
//  Created by C on 2019/8/1.
//  Copyright © 2019 THYG. All rights reserved.
//

#ifndef THNetworkCondition_h
#define THNetworkCondition_h



#endif /* THNetworkCondition_h */
//测试环境
#ifdef CI

static NSString *const kLoginPath = @"";
static NSString *const kRegisterPath = @"";
static NSString *const kSendMobileCodePath = @"";
static NSString *const kGetUserInfoPath = @"";
static NSString *const kUpdateUserInfoPath = @"";
static NSString *const kUpdateAddressPath = @"";
static NSString *const kAddAddressPath = @"";
static NSString *const kTaskListPath = @"";
static NSString *const kUnboxingPath = @"";
static NSString *const kInviteListPath = @"";
static NSString *const kAttentionListPath = @"";
static NSString *const kUploadImageDataPath = @"";
static NSString *const kCouponListPath = @"";

#else
//正式环境
static NSString *const kLoginPath = @"";
static NSString *const kRegisterPath = @"";
static NSString *const kSendMobileCodePath = @"";
static NSString *const kGetUserInfoPath = @"";
static NSString *const kUpdateUserInfoPath = @"";
static NSString *const kUpdateAddressPath = @"";
static NSString *const kAddAddressPath = @"";
static NSString *const kTaskListPath = @"";
static NSString *const kUnboxingPath = @"";
static NSString *const kInviteListPath = @"";
static NSString *const kAttentionListPath = @"";
static NSString *const kUploadImageDataPath = @"";
static NSString *const kCouponListPath = @"";


#endif

