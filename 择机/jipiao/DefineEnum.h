//
//  DefineEnum.h
//  wallet
//
//  Created by xingxing on 15/11/9.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#ifndef DefineEnum_h
#define DefineEnum_h

#define ZEJIIN  @"ZEJIIN"   //已经登录
#define ZEJIOUT  @"ZEJIOUT"//未登录或者已退出

//乘机人状态
#define psgStatusZhengChang   @"1" //1：正常
#define psgStatusTuiPiaoZhong   @"2"//2：退票申请中
#define psgStatusYiTuiPiao   @"3"//3：已退票
#define psgStatusYiGaiQian   @"4"//4：已改签

typedef enum {
    DOCUMENTTYPE_ID,         //身份证
    DOCUMENTTYPE_PASSPORT,    //护照
    DOCUMENTTYPE_OTHER,    //其他
}DOCUMENTTYPE; //机票类型

typedef enum {
    DOMESTICAIRTICKETS,         //国内机票
    INTETNATIONALAIRTICKETS,    //国际机票
}AIRLINETICKETTYPE; //机票类型
typedef enum {
    ENUM1,          //返回打开app时候的那个控制器
    ENUM2,          //去登录注册
    ENUM3,
}ENUMTTYPE; //枚举
typedef enum {
    journeyTypeENUM1,          //1：单程
    journeyTypeENUM2,          //2：往返
    journeyTypeENUM3,          //3：联程
}journeyTypeTYPE; //枚举 航程类型

#define  directionLeft  1
#define  directionRight  2

#define MYHOMEPATH [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject]
#define USERINFOPATH  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"userZEinZEfo.plist"]
#define APPORURL  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"appOrUrl.plist"]
#define LEFTDATA  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"apleftdatapOrUrl.plist"]

#define ALLHDATA  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"aplefALLHDATAtdatapOrUrl.plist"]

#define GRXXDATA  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"apGRXXDATAapOrUrl.plist"]  //个人信息
#define accessTokenInfoPATH  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"accZEessTokenInfo.plist"]
#define accessTokenInfoDatePATH  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"accZEessTokenInfoDate.plist"] //token的更新时间
#define ZEJIKEFUInfoPATH  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ZEJIZEKEFUInfoPATH.plist"]
#define ZEJIKECYCJRPATH  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ZEJIZEcontactsCYCJRPATH.plist"]  //常用乘机人列表
#define ZEJIKEMISHUPATH  [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ZEJIconZEtactsmishuPATH.plist"]  //秘书列表
//#define ZEJIICON [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"ZEJIICONZEJIICON"]  //头像
#define ZEJIICON @"ZEJIICONpHone"  //头像
//通用支付接口用到的
#define JPZF @"JPZF"
#define XCZF @"XCZF"
#define BXZF @"BXZF"
#define DZZF @"DZZF"
#define HKZF @"HKZF"

#define wechat @"wechat"
#define alipay @"alipay"
#define tpurse @"tpurse"
#define flyCredit @"flyCredit"
//typedef enum {
//    JPZF,         //机票购买支付
//    XCZF,    //:行程单配送支付
//    BXZF,         //保险支付
//    DZZF,    //订制支付
//    HKZF,         //信用还款支付
//}PAYTYPE; //支付类型
//typedef enum {
//    wechat,         //微信
//    alipay,    //支付宝
//    tpurse,         //T钱包
//    flyCredit,    //飞行信用
//}PAYCHANNEL; //支付渠道


//网络请求状态
typedef NS_ENUM(NSInteger, RespondCode)
{
    kRespondCodeNotJson            = -1,
    kRespondCodeSuccess            = 0,
    kRespondCodeOutDateAccessToken = 100008,//AccessToken不存在或已过期  传入有效的 AccessToken
    KRespondCodeLoginTimeOut       = -105, //刷新验证票
    KRespondCodeFail               = -10000, //请求失败
};
#define Myorder @"order"  //联系秘书  用来与安卓发扩展消息
#define TSZFTSZF @"msgtype"  //用来判断字典里面是否有某一个键值

#define TSMSGTITLE @"系统提示"  //用来判断字典里面是否有某一个键值
#define TSMSGONE @"TSMSGONE"  //用来判断字典里面是否有某一个键值
#define TSMSGTWO @"TSMSGTWO"  //用来判断字典里面是否有某一个键值

#define ZJLXR  @"1" //常用乘机人
#define ZJMS    @"2"   //秘书

//订单状态0全部 00待付款 02待发货 03:已发货 04待收货 05已收货 06交易完成 07退款/售后 08 交易关闭
#define kMyOrderStateAll            @"0"
#define kMyOrderStateStayPay        @"00"
#define kMyOrderStateStaySend       @"02"
#define kMyOrderStateAlreadySend    @"03"
#define kMyOrderStateStayReceive    @"04"
#define kMyOrderStateAlreadyReceive @"05"
#define kMyOrderStateTradeComplete  @"06"
#define kMyOrderStateAfterSale      @"07"
#define kMyOrderStateTradeClose     @"08"

// clang-format on
#define HXMIMA @"111111"


#define ZEJIHJMS  @"呼叫秘书"   //呼叫秘书的标题

#endif /* DefineEnum_h */
