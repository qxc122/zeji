//
//  DefineCommon.h
//  wallet
//
//  Created by xingxing on 15/11/9.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#ifndef DefineCommon_h
#define DefineCommon_h

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//通知
#define Receivecustomerserviceordernumber @"Receivecustomerserviceordernumber"    //收到客服的订单号码
#define Returntothemaininterface @"Returntothemaininterface"    //返回主界面
#define Domesticairtickets @"Domesticairtickets"    //国内机票
#define Closetherightinterface @"Closetherightinterface"    //关闭左右边界面

#define ChangeTheBadgeZejiMain @"ChangeTheBadgeZejiMain"    //改变未读消息数
#define ChangeTheBadgeZejiKefu @"ChangeTheBadgeZejiKefu"    //客服未读消息数

#define CallPhone @"CallPhone"    //去打电话
#define ZEJILoginsuccess @"ZEJILoginsuccess"    //登录成功
#define ZEJIICONUPLOAD @"ZEJIICONUPLOAD"    //头像下载OK
#define ZEJILogOutsuccess @"ZEJILogOutsuccess"    //退出成功
#define AvatarUploadSuccess @"AvatarUploadSuccess"    //头像上传成功
#define NAMEUploadSuccess @"NAMEUploadSuccess"    //名字修改成功


#define NOTIFINAME_ADDSECRETARY  @"NOTIFINAME_ADDSECRETARY"  //添加秘书时调用通讯录的通知名称
#define NOTIFINAME_ADDFRIENDS   @"NOTIFINAME_ADDFRIENDS"  //添加好友时调用通讯录的通知名称
#define NOTIFINAME_ADDFRIENDSSUCCES  @"NOTIFINAME_ADDFRIENDSSUCCES"  //添加秘书时调用通讯录的通知名称
#define NOTIFINAME_RESETCOOKIE  @"NOTIFINAME_RESETCOOKIE"  //需要重新设置cokie
#define NOTIFINAME_RELOAD  @"NOTIFINAME_RELOAD"  //需要刷新网页
#define NOTIFINAME_REGETDATA  @"NOTIFINAME_REGETDATA"  //在首页需要重新获取参数

//通用支付接口用到的  统一支付
#define wechatTYZF  @"wechat" //"wechat:微信
#define alipayTYZF  @"alipay"//alipay:支付宝
#define tpurseTYZF  @"tpurse"//tpurse：t钱包
#define flyCreditTYZF  @"flyCredit"//flyCredit:飞行信用"
#define JPZFTYZF  @"JPZF"//"JPZF:机票购买支付
#define XCZFTYZF  @"XCZF"//XCZF:行程单配送支付
#define BXZFTYZF  @"BXZF"//BXZF:保险支付
#define DZZFTYZF  @"DZZF"//DZZF:订制支付
#define HKZFTYZF  @"HKZF"//HKZF:信用还款支付"

//H5有关要用到的
//H5的通知
#define H5Startloading @"Startloading"    //H5开始加载
#define H5Startoperation @"Startoperation"    //H5开始操作
#define H5TISHIMSG @"H5TISHIMSG"    //H5的提示消息
#define H5Historyrefresh @"H5Historyrefresh"    //H5通知历史纪录刷新
#define H5HIDENMAINRIGHT @"H5HIDENMAINRIGHT"    //H5通知隐藏历史记录
#define H5SHOWMAINRIGHT @"H5SHOWMAINRIGHT"    //H5通知显示历史记录
#define H5Popupbox @"H5Popupbox"    //H5通知弹出登录框
//#define H5homeContactCustomerService @"H5homeContactCustomerService"    //H5通知首页联系客服(queryHint=航班信息)
//#define H5homeContactSecretary @"H5homeContactSecretary"    //H5通知联系秘书
//#define H5contactCustomerService @"H5contactCustomerService"    //H5联系客服（不带参数）
//#define H5openNewVIewWithUrl @"H5openNewVIewWithUrl"//H5打开新的webView
#define H5callContacts @"H5callContacts"//H5调用通讯录

//H5
#define H5MSGMAINqueryHint @"H5MSGH5MSGH5MSG"//H5通知首页联系客服 (queryHint=航班信息)
#define H5MSGMAINjsonSt @"H5MSGMAINjsonSt"//H5//联系客服（带票） jsonSt

//start
#define H5MSGMAINeasemo @"H5MSGMAINeasemo"//H5(easemobId=秘书id,queryHint=航班信息)
#define H5MSGMAINeasemoeasemobId @"H5MSGMAINeasemoeasemobId"//H5(easemobId=秘书id
#define H5MSGMAINeasemoqueryHint @"H5MSGMAINeasemoqueryHint"//H5 queryHint=航班信息)
// end
//H5有关要用到的 end

#define RIRHTEXECUTIVEHOMEPAGE @"Rightexecutivehomepage"    //右侧滑执行主页面的通知

#define NaVc  (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController


#define   ZJCHANNEL             @"1"//交易渠道 M 1择机  2T钱包
#define   ZJserviceCode         @""//服务编号 O
#define   ZJexternalReferenceNo @""//内部流水号 O
#define   ZJuserReferenceNo     @""//外部流水号 O 交易流水号，必须唯一
#define   ZJstepCode            @"1"//步骤编号  M 默认1
#define   ZJaccessSource        @"2"//访问源 M 1-PC 2-IOS 3-Android 4-其他
#define   ZJaccessSourceType    phoneVersion//指手机类型,系统版本 O
#define   ZJversion             @"1.0"//接口版本号 M 默认1.0


//#define  backRGB  RGBColor(23, 36,52)
#define nacbacktouming1   [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault]
#define nacbacktouming2  self.navigationController.navigationBar.shadowImage=[UIImage new]
#define nacbackNOtouming [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"hanbanchaxun"] forBarMetrics:UIBarMetricsDefault]


//#ifdef DEBUG
//#define NSLog(...) NSLog(__VA_ARGS__)
//#else
//#define NSLog(...)
//#endif

#define  HIDENnavigationBar   [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bg_clear"] forBarMetrics:UIBarMetricsDefault]

// app版本
#define app_Version [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// app build版本
#define app_build [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
// 手机系统 版本
#define phoneVersion [[UIDevice currentDevice] systemVersion]

#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight  [UIScreen mainScreen].bounds.size.height

#define APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]

#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define TW_SYSTEM_VERSION_LESS_THAN(v)   ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define TW_SYSTEM_VERSION_HIGGER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#define WIDTHICONCHAT  35  //聊天页面头像大小
#define cornerRadiusCHAT  4.0  //聊天页面头像
#define SPAINGHICONCHAT  5  //聊天头像超出文字的高度

#define  longafteryoucancontactcustomerservice  60  //多久后可以联系客服 60为一分钟

#endif /* DefineCommon_h */
