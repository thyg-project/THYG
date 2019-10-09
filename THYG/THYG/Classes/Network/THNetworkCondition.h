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

static NSString *const kServerDomain = @"http://mp.wushibu.cn/index.php/api/v100";


#else
//正式环境

static NSString *const kServerDomain = @"http://th1818.bingogd.com/api/v100";

#endif
///登录
#define kLoginPath [kServerDomain stringByAppendingString:@"/Login/login"]
///获取用户信息
#define kGetUserInfoPath [kServerDomain stringByAppendingString:@"/User/userinfo"]
///注册
#define kRegisterPath  [kServerDomain stringByAppendingString:@"/Login/register"]
///发送验证码
#define kSendMobileCodePath [kServerDomain stringByAppendingString:@"/User/send_validate_code"]
///更新用户信息
#define kUpdateUserInfoPath  [kServerDomain stringByAppendingString:@"/User/updateUserInfo"]
///更新收获地址
#define kUpdateAddressPath  [kServerDomain stringByAppendingString:@"/Address/post"]
///添加收货地址列表
#define kAddAddressPath  [kServerDomain stringByAppendingString:@"/Login/login"]
///任务列表
#define kTaskListPath  [kServerDomain stringByAppendingString:@"/Login/login"]
///晒单
#define kUnboxingPath  [kServerDomain stringByAppendingString:@"/Order/myCommentList"]
///邀请列表
#define kInviteListPath  [kServerDomain stringByAppendingString:@"/Login/login"]
///关注列表
#define kAttentionListPath  [kServerDomain stringByAppendingString:@"/User/collectList"]
///上传图片
#define kUploadImageDataPath  [kServerDomain stringByAppendingString:@"/User/upload_headpic"]
///优惠券列表
#define kCouponListPath  [kServerDomain stringByAppendingString:@"/User/couponList"]
///银行卡列表
#define kBankListPath  [kServerDomain stringByAppendingString:@"/User/bankCardList"]
///钱包信息
#define kWalletInfoPath [kServerDomain stringByAppendingString:@"/User/wallet"]
///签到
#define kSignPath [kServerDomain stringByAppendingString:@"/User/sign"]
///收货地址列表
#define kAddressListPath [kServerDomain stringByAppendingString:@"/Address/getUserAddressList"]
///删除收货地址
#define kDeleteAddressPath [kServerDomain stringByAppendingString:@"/Address/delete"]
///设置默认收货地址
#define kSetDefaultAddressPath [kServerDomain stringByAppendingString:@"/Address/setDefault"]
///编辑收货地址
#define kEditAddressPath [kServerDomain stringByAppendingString:@"/Login/login"]
///退出登录
#define kLogoutPath [kServerDomain stringByAppendingString:@"/Login/login"]
///修改密码
#define kModifyPwdPath [kServerDomain stringByAppendingString:@"/User/password"]
///忘记密码
#define kForgetPwdPath [kServerDomain stringByAppendingString:@"/User/set_pwd"]
///申请成为供应商
#define kApplySuppplierPath [kServerDomain stringByAppendingString:@"/User/applySupplier"]
///申请成为推广专员
#define kApplyPromotionSpecialistPath [kServerDomain stringByAppendingString:@"/User/applyPromotionSpecialist"]
///用户足迹
#define kGetVisitPath [kServerDomain stringByAppendingString:@"/User/getVisit"]
///添加银行卡
#define kAddBankPath [kServerDomain stringByAppendingString:@"/User/addBankCard"]
///收藏
#define kCollectGoodPath [kServerDomain stringByAppendingString:@"/Goods/collectionGoods"]
///猜你喜欢
#define kFavouriteGoodsPath [kServerDomain stringByAppendingString:@"/Goods/favouriteGoods"]
///秒杀
#define kFlashSaleListPath [kServerDomain stringByAppendingString:@"/Activity/getFlashSaleList"]
///分类
#define kGoodsCategoryPath [kServerDomain stringByAppendingString:@"/Goods/getGoodsCategory"]
///购物车列表
#define kCartsListPath [kServerDomain stringByAppendingString:@"/Cart/getCartList"]
///购物车全选
#define kCardSelectedAllPath [kServerDomain stringByAppendingString:@"/Cart/selectAll"]
///购物车删除
#define kCardDeletePath [kServerDomain stringByAppendingString:@"/Cart/delete"]
///商品移入我的关注
#define kCardMoveToCollectPath [kServerDomain stringByAppendingString:@"/Cart/moveToCollect"]
///改变购物车单个数量
#define kCardChangeGoodsNumPath [kServerDomain stringByAppendingString:@"/Cart/changeNum"]
///退货订单列表
#define kOrderReturnGoodsListPath [kServerDomain stringByAppendingString:@"/Order/getReturnGoodsList"]
///购买订单列表
#define kOrderSalesGoodsListPath [kServerDomain stringByAppendingString:@"/Order/getUserOrderList"]
///删除订单
#define kDeleteOrderPath [kServerDomain stringByAppendingString:@"/Order/delete"]
///取消订单
#define kCancelOrderPath [kServerDomain stringByAppendingString:@"/Order/cancel"]
///查看物流信息
#define kOrderExpressPath [kServerDomain stringByAppendingString:@"/Order/express"]
///提醒发货
#define kOrderNoticePath [kServerDomain stringByAppendingString:@"/Order/notice"]
///订单详情
#define kOrderDetailPath [kServerDomain stringByAppendingString:@"/Order/detail"]
///创建订单
#define kOrderCreatePath [kServerDomain stringByAppendingString:@"/Order/create"]
///订单提交
#define kOrderSubmitPath [kServerDomain stringByAppendingString:@"/Order/submit"]
///支付订单
#define kOrderPayPath [kServerDomain stringByAppendingString:@"/pay/payOrder"]
///获取用户基本信息
#define kPersonalCenterInfoPath [kServerDomain stringByAppendingString:@"/PersonalCenter/personal"]

#define kVisitListPath [kServerDomain stringByAppendingString:@"/User/getVisitList"]
///可用优惠券
#define kCouponCanUsedPath [kServerDomain stringByAppendingString:@"/User/coupon"]
///地区选择数据
#define kAddressProvienceInfoPath [kServerDomain stringByAppendingString:@"/Address/getAddressList"]
///搜索结果
#define kSearchGoodListPath [kServerDomain stringByAppendingString:@"/Goods/getGoodsList"]
///添加购物车
#define kAddCardPath [kServerDomain stringByAppendingString:@"/Cart/addCart"]
///获取商品详情
#define kGetGoodsDetailPath [kServerDomain stringByAppendingString:@"/Goods/getGoodsDetail"]
///获取商品评论
#define kGetGoodCommentListPath [kServerDomain stringByAppendingString:@"/Goods/getCommentList"]

#define kGetGoodsSpecInfoPath [kServerDomain stringByAppendingString:@"/Cart/getCartSpec"]
