//
//  DefineURL.h
//  wallet
//
//  Created by xingxing on 15/11/9.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#ifndef                           DefineURL_h
#define                           DefineURL_h

#define VERNUM  @"V 1.3.3"
#define   REQUESTFAIL  @"操作失败"
#ifdef DEBUG
#define OPenHx  NO
#else
#define OPenHx  NO
#endif


//#define aboutZEJI @"/web/aboutZeji.html"  //关于择机
//
//#define mainUrl @"/web/index.html"      //机票app的主页面
//
//#define myOrder @"/web/myOrder.html"      //机票app 我的订单页面
//
//
//#define  zhifugoupiaoURL  @"/web/paidTicketsChina.html"   //支付购票页面地址
//
////测试环境地址变更：http://zeji.tempus.cn/zeji-front/test
////准生产环境地址变更：http://zeji.tempus.cn/zeji-front/preprod
//#ifdef DEBUG
//#define kURLAPIBase @"http://172.18.126.58:8041/zeji-front"//测试环境地址变更  测试  58


//#define DEBUGLONG

//#define mylongOrderName @"优惠码"  //long
//#define mylongOrderUrl @"/web/MyCoupon.html"  //long

#define aboutZEJI @"/dist/aboutZeji.html"  //关于择机
#define mainUrl @"/web/index.html"      //机票app的主页面
//#define mainUrl @"/web/test.html"      //机票app的主页面
#define myOrder @"/web/index.html#/my-order"      //机票app 我的订单页面
#define  zhifugoupiaoURL  @"/web/index.html#/pay-tickets"   //支付购票页面地址

//测试环境地址变更：http://zeji.tempus.cn/zeji-front/test
//准生产环境地址变更：http://zeji.tempus.cn/zeji-front/preprod
#ifdef DEBUG
//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front/preprod"//测试环境地址变更  测试  58
//#define kURLAPIBase @"http://172.18.126.105:8061/zeji-front"//测试环境地址变更  测试  58
#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front/test"//测试环境地址变更  测试  58
//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front"

//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front"
//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front"

//#define kURLAPIBase @"http://zeji.tempus.cn/zeji-front/preprod"//准生产环境地址变更

//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front/test"//测试环境地址变更  测试
//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front/preprod"//准生产环境地址变更
//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front"//正式
#else
//#define kURLAPIBase @"http://zeji.tempus.cn/zeji-front/preprod"//准生产环境地址变更

//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front/test"//测试环境地址变更
//#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front/preprod"//准生产环境地址变更
#define kURLAPIBase @"https://zeji.tempus.cn/zeji-front"

#endif

#define     REQUESTURLappIdApply        @"/app/appIdApply"       //申请appId和appSerect
#define     REQUESTURLtokenApply        @"/app/tokenApply"       //申请token
#define     REQUESTURLrefreshLogin        @"/user/refreshLogin"       //申请token
#define     REQUESTURLappUpdate         @"/app/appUpdate"        //App版本更新
#define     REQUESTURLgetCooperationApp @"/app/getCooperationApp"//首页应用列表获取
#define     REQUESTURLgetGlobalParams @"/app/getGlobalParams"//获取一些杂信息
#define     REQUESTURLsendVerifyCode    @"/system/sendVerifyCode"//发送短信验证码
#define     REQUESTURLlogin             @"/user/login"           //验证码登录
#define     REQUESTURLqueryMenu         @"/system/queryMenu"     //左侧菜单查询
#define     REQUESTURLgetMyInfo         @"/user/getMyInfo"       //获取我的信息
#define     REQUESTURLcashpay         @"/cash/pay"             //通用支付
#define     REQUESTURLpayStatusQuery         @"/cash/payStatusQuery"             //查询支付状态
#define     REQUESTURLweChatLogin         @"/user/weChatLogin"        //微信登录
#define     REQUESTURLweChatlogout         @"/user/logout"        //退出登录

#define     REQUESTURLFlightQueryHistory         @"/flight/FlightQueryHistory"     //查询航班查询记录
#define     REQUESTURLAddFlightQuery         @"/flight/AddFlightQuery"               //增加航班查询记录
#define     REQUESTURLCleanFlightQuery         @"/flight/CleanFlightQuery"             //清除航班查询记录

#define     REQUESTURLaddContact        @"/user/addContact"             //新增联系人
#define     REQUESTURLMyInfoModify        @"/user/modifyMyInfo" //修改我的信息
#define     REQUESTURLeditContact         @"/user/editContact"               //修改联系人
#define     REQUESTURLqryContact         @"/app/qryContact"//联系人列表查询
#define     REQUESTURLcontactDetailQuery         @"/user/contactDetailQuery"//联系人详细信息查询
#define     REQUESTURLgetEasemobInfo         @"/user/getEasemobInfo"//根据环信ID查询头像，名字，电话
#define     REQUESTURLdeleteContact         @"/user/deleteContact"             //删除联系人
#define     REQUESTURLcouponCodeRecharge  @"/user/couponCodeRecharge"             //优惠码充值
#define     REQUESTURLavatarUpload         @"/user/avatarUpload"             //上传头像
#define     REQUESTURLorderInfo      @"/order/orderInfo"        //订单明细查询
#define     REQUESTURLmyBill     @"/user/myBill"        //我的账单
#define     REQUESTURLqueryMyCredit    @"/user/queryMyCredit"        //查询个人信用信息
#endif /* DefineURL_h */
