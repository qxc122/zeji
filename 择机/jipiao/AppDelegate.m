//
//  AppDelegate.m
//  jipiao
//
//  Created by admin on 16/7/25.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "AppDelegate.h"
#import "HeaderTotal.h"
#import "mainController.h"
#import "EaseUI.h"
#import "AppTools.h"
#import "WechatManager.h"
//#import "LoginViewController.h"
#import "baseVc.h"
#import "mainController.h"
#import "MZGuidePages.h"
#import <AddressBook/AddressBook.h>
#import "ChatViewController.h"
#import "NSDate-Utilities.h"
#import "payOk.h"

#import "SDWebImageManager.h"
#import "SDImageCache.h"

#define WIDTHtiaoguo  80
#define HEIGHTtiaoguo 25
#define WIDTHlabelSes 20
#define SPaceingToToplabelSes 22





//#import "AppDelegate+UMeng.h"
//#import "AppDelegate+Parse.h"
//#import "RedPacketUserConfig.h"
//#import "AlipaySDK.h"
//#import "RedpacketOpenConst.h"

@interface AppDelegate ()<EMClientDelegate,WXApiDelegate>
@property (nonatomic,strong) mainController *mainController;


@property (nonatomic,weak) UIImageView *Advertisement;
@property (nonatomic,weak) UILabel *labelsss;
@property (nonatomic, strong) NSTimer *timer;
@end


@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // Override point for customization after application launch.
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    _connectionState = EMConnectionConnected;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];   //设置通用背景颜色

//    payOk *main = [[payOk alloc] init];
    mainController *main = [[mainController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:main];
    self.mainController = main;
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    if ([UIDevice currentDevice].systemVersion.floatValue >= 7.0) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"hanbanchaxun"] forBarMetrics:UIBarMetricsDefault];
        
        [[UINavigationBar appearance] setTitleTextAttributes:
         [NSDictionary dictionaryWithObjectsAndKeys:RGBACOLOR(245, 245, 245, 1), NSForegroundColorAttributeName, [UIFont systemFontOfSize:17], NSFontAttributeName, nil]];
    }

    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EaseSDKHelper shareHelper] hyphenateApplication:application
                      didFinishLaunchingWithOptions:launchOptions
                                             appkey:HXAppKey
                                       apnsCertName:HXapnsCertName
                                        otherConfig:@{kSDKConfigEnableConsoleLogger:[NSNumber numberWithBool:YES]}];

    if (![[Ticket sharedInstance] judgeIsSaveAppidAndAppSecret]) {
        [self fetchAppID];
    }else{
        [self checkToken];
    }

    [WXApi registerApp:WechatAppID];
    [Ticket sharedInstance];
    
    
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[ChatViewController class]];
    [[IQKeyboardManager sharedManager] disableToolbarInViewControllerClass:[EaseMessageViewController class]];
    
    [AppTools onFirstStartForCurrentVersion:^(BOOL isFirstStartForCurrentVersion) {
        if (isFirstStartForCurrentVersion) {
            NSLog(@"首次启动显示App引导页");
            [self guidePages];
        } else {
            NSLog(@"显示广告页");
            [self gaugngggg];
//            [self showStartImageView];
        }
    }];

    UMConfigInstance.appKey = UMappKey;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
#if DEBUG
    [MobClick setLogEnabled:YES];
#else
    [MobClick setLogEnabled:NO];
#endif

    return YES;
}

- (void)gaugngggg{
    GlobalParams *arrryDes = [NSKeyedUnarchiver unarchiveObjectWithFile:ALLHDATA];
    if (arrryDes.startPicture && arrryDes.startPicture.length) {
        [self setUi];
        NSString* strUrl = arrryDes.startPicture;
        SDWebImageManager *manager = [SDWebImageManager sharedManager];
        NSString* key = [manager cacheKeyForURL:[NSURL URLWithString:strUrl]];
        SDImageCache* cache = [SDImageCache sharedImageCache];
        //此方法会先从memory中取。
        UIImage *caImage = [cache imageFromDiskCacheForKey:key];
        if (caImage) {
            self.Advertisement.image = caImage;
        }else{
            [self.Advertisement sd_setImageWithURL:[NSURL URLWithString:arrryDes.startPicture]];
        }
        [self startTimer];
    }
}
- (void)setUi{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIImageView *Advertisement = [[UIImageView alloc]init];
    //    Advertisement.backgroundColor = [UIColor redColor];
    self.Advertisement  =Advertisement;
    //    Advertisement.image = [UIImage imageNamed:@"点击0001"];
    [window addSubview:Advertisement];
    
    UIButton *tiaoguo = [[UIButton alloc]init];
    [Advertisement addSubview:tiaoguo];
    
    UILabel *labelSes = [[UILabel alloc]init];
    self.labelsss = labelSes;
    [Advertisement addSubview:labelSes];
    
    [Advertisement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(window);
        make.right.equalTo(window);
        make.top.equalTo(window);
        make.bottom.equalTo(window);
    }];
    
    [labelSes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(Advertisement).offset(-SPaceingToToplabelSes);
        make.top.equalTo(Advertisement).offset(SPaceingToToplabelSes);
        make.height.equalTo(@(HEIGHTtiaoguo));
        //        make.width.equalTo(@(WIDTHlabelSes));
    }];
    [tiaoguo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(labelSes.mas_left).offset(-3);
        make.top.equalTo(labelSes);
        //        make.width.equalTo(@(WIDTHtiaoguo));
        make.bottom.equalTo(labelSes);
    }];
    Advertisement.userInteractionEnabled = YES;
    [tiaoguo setTitle:@"跳过" forState:UIControlStateNormal];
    [tiaoguo addTarget:self action:@selector(tiaoguoClick) forControlEvents:UIControlEventTouchUpInside];
    
    labelSes.textAlignment = NSTextAlignmentCenter;
    //test
    labelSes.font = [UIFont systemFontOfSize:14.0];
    tiaoguo.titleLabel.font = [UIFont systemFontOfSize:14.0];
    //    Advertisement.image = [UIImage imageNamed:@"点击0001"];
    labelSes.text = @"3";
    labelSes.textColor = [UIColor redColor];
    //    tiaoguo.layer.cornerRadius = HEIGHTtiaoguo/2.0;
    //    tiaoguo.layer.masksToBounds = YES;
    //    tiaoguo.layer.borderColor = [UIColor whiteColor].CGColor;
    //    tiaoguo.layer.borderWidth = 1.0;
    //如果定时器已开启，先停止再重新开启
}

- (void)startTimer {

    if (self.timer) [self stopTimer];
    self.timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(nextSesss) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)nextSesss{
    NSString *tmp = self.labelsss.text;
    NSInteger num = [[tmp stringByReplacingOccurrencesOfString:@"s" withString:@""] integerValue];
    num--;
    if (num==0) {
        [self tiaoguoClick];
    } else {
        self.labelsss.text = [[NSString stringWithFormat:@"%ld",(long)num] stringByAppendingFormat:@""];
    }
}
- (void)tiaoguoClick{
    //跳过
    [UIView animateWithDuration:1.0f animations:^{
        self.Advertisement.alpha = 0;
    } completion:^(BOOL finished) {
        [self.Advertisement removeFromSuperview];
        self.Advertisement = nil;
        self.labelsss = nil;
        [self stopTimer];
    }];
}


- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)checkToken{
    NSDate *oldDate = [NSKeyedUnarchiver unarchiveObjectWithFile:accessTokenInfoDatePATH];
    
    NSDate *now = [NSDate date];
//    NSString *now = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    NSTimeInterval time = [now timeIntervalSinceDate:oldDate];
    
    NSLog(@"time:%f",time/60/60/24);
    
    accessTokenInfo *token = [NSKeyedUnarchiver unarchiveObjectWithFile:accessTokenInfoPATH];
    if (time>([token.expireTime longLongValue]-60*60)) {
        [[Ticket sharedInstance] RefreshTheAccessTokeninfo];
    }
    
}
- (void)guidePages
{
    NSArray *imageArray = nil;
    if (iPhone6plus || iPhone6 || iPhone5) {
        imageArray = @[ @"hhh1", @"hhh2",@"hhh3", @"hhh4",@"hhh5",@"hhh6"];
    } else {
        imageArray = @[ @"hhh1", @"hhh2",@"hhh3", @"hhh4",@"hhh5",@"hhh6"];
    }
    
    MZGuidePages *mzgpc = [[MZGuidePages alloc] init];
    mzgpc.imageDatas = imageArray;
    __weak typeof(MZGuidePages) *weakMZ = mzgpc;
    mzgpc.buttonAction = ^{
        [UIView animateWithDuration:1.0f
                         animations:^{
                             weakMZ.alpha = 0.0;
                         }
                         completion:^(BOOL finished) {
                             [weakMZ removeFromSuperview];
                         }];
    };
    
    [self.window addSubview:mzgpc];
}
#pragma mark - App Delegate

// 将得到的deviceToken传给SDK
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [[EMClient sharedClient] bindDeviceToken:deviceToken];
    });
}

// 注册deviceToken失败，此处失败，与环信SDK无关，一般是您的环境配置或者证书配置有误
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{

}

#pragma mark - network
- (void)fetchAppID
{
    __weak typeof(self) weakSelf = self;
    [[TWClient sharedInstance] appIdApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSLog(@"首次获取appid成功");
        [[Ticket sharedInstance] updateAppid:dataDict[@"appId"] appSecret:dataDict[@"appSecret"]];

    }failure:^(NSInteger errorCode, NSString *msg) {
//        [self fetchAppID];
        [weakSelf performSelector:@selector(fetchAppID) withObject:nil afterDelay:0.5f];
        NSLog(@"获取appid失败 %@", msg);
        //TODO:
    }];
}
- (void)didAutoLoginWithError:(EMError *)aError{
    //添加回调监听代理:
    NSLog(@"环信自动登录成功");
}
/*!
 *  当前登录账号在其它设备登录时会接收到该回调
 */
- (void)didLoginFromOtherDevice{
    [MBProgressHUD showError:@"您的帐号在其他设备登录"];
    [self logoutAndProloginView];
}
- (void)logoutAndProloginView{
    [self.mainController.navigationController popToRootViewControllerAnimated:YES];
    [[TWClient sharedInstance]logoutsuccess:^(id dataDict, NSString *msg, NSInteger code) {
        [[Ticket sharedInstance]updateLogininfo:ZEJIOUT];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"GoZeJiregisterNotificationCenter" object:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        
    }];
}
/*!
 *  当前登录账号已经被从服务器端删除时会收到该回调
 */
- (void)didRemovedFromServer{
    [MBProgressHUD showError:@"您的帐号被删除,请重新登录"];
    [self logoutAndProloginView];
}

- (void)didConnectionStateChanged:(EMConnectionState)aConnectionState{
    if (aConnectionState == 0) {
        NSLog(@"环信已连接");
    } else {
        NSLog(@"环信未连接");
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
//app进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//    [[EMClient sharedClient] applicationDidEnterBackground:application];
}
//app从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self checkToken];
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
//    UIViewController *Vc = [[UIViewController alloc]init];
//    Vc.view.backgroundColor = [UIColor redColor];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:Vc];
//    self.window.rootViewController = nav;
//    [self.window makeKeyAndVisible];

    if (_mainController) {
        
        [_mainController jumpToChatList];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (_mainController) {
        [_mainController didReceiveLocalNotification:notification];
    }
}
#pragma mark---微信登录
- (void)onResp:(BaseResp *)resp
{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp *response = (PayResp *)resp;
        switch(response.errCode) {
            case WXSuccess:
                NSLog(@"%@",[NSThread currentThread]);
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPaySuccess" object:nil];
                break;
            case WXErrCodeUserCancel:
                NSLog(@"用户取消");
                [MBProgressHUD showError:@"您已经取消支付"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayUserCancel" object:nil];
                break;
            default:
                [MBProgressHUD showError:@"支付失败"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayFaild" object:nil];
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }
    else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp *response = (SendMessageToWXResp *)resp;
        switch(response.errCode) {
            case WXSuccess:
                    [MBProgressHUD showSuccess:@"分享成功"];
                break;
            case WXErrCodeUserCancel:
                    [MBProgressHUD showError:@"取消分享"];
                break;
            default:
                    [MBProgressHUD showError:@"分享失败"];
                break;
        }
    }
    else if ([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *aresp = (SendAuthResp *)resp;
        if (resp.errCode == 0) {
            NSString *code = aresp.code;
            NSLog(@"ccode------%@", code);
            [[WechatManager sharedInstance] wechatGetcode:code andsuccess:^(NSDictionary *dic) {
                NSLog(@"-----------dic---%@", dic);
                [self thirdLoginWithDictionary:dic];
                [WXApi registerApp:WechatAppID];
            }];
        }
    }
}

- (void)thirdLoginWithDictionary:(NSDictionary *)dict
{
    NSString *nickname = [dict objectForKey:@"nickname"];
    [[TWClient sharedInstance]weChatLoginWithnickname:nickname province:[dict objectForKey:@"province"]  city:[dict objectForKey:@"city"] gender:[dict objectForKey:@"sex"] avatar:[dict objectForKey:@"headimgurl"] openIdType:@"Weixin" country:[dict objectForKey:@"country"] openId:[dict objectForKey:@"openid"] unionid:[dict objectForKey:@"unionid"] success:^(id dataDict, NSString *msg, NSInteger code) {
        [[Ticket sharedInstance]updateuserinfo:[MTLJSONAdapter modelOfClass:[userInfo class] fromJSONDictionary:dataDict error:nil] success:^(id dataDict, NSString *msg, NSInteger code) {
            [MBProgressHUD showSuccess:@"微信登录成功"];
        } failure:^(NSInteger errorCode, NSString *msg) {
            [MBProgressHUD showSuccess:@"微信登录失败"];
        }];
        [[Ticket sharedInstance]updateLogininfo:ZEJIIN];
    } failure:^(NSInteger errorCode, NSString *msg) {
        [MBProgressHUD showSuccess:@"微信登录失败"];
    }];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    bool tmp = NO;
    tmp = [WXApi handleOpenURL:url delegate:self];
    if (tmp == NO) {
        tmp = [self zejipay:url];
    }
    return tmp;
}
- (BOOL)zejipay:(NSURL *)url{
    BOOL tmp;
    if ([[url absoluteString] hasPrefix:@"zeji"]) {
        NSString *resUrl = [url absoluteString];
        resUrl = [resUrl stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *muDic = [resUrl getURLParametersFromUrl];
        
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        NSData *imageData = [pasteboard dataForPasteboardType:@"dataToZeji"];
        NSDictionary *data = [self returnDictionaryWithDataPath:imageData];
        
        NSString *strMsg;
        if (muDic) {
            strMsg = muDic[@"mmssgg"];
        } else {
            strMsg = data[@"mmssgg"];
        }
        if ([strMsg isEqualToString:@"支付成功"]) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPaySuccess" object:nil];
        } else if ([strMsg isEqualToString:@"用户取消"]){
            [MBProgressHUD showError:@"您已经取消支付"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayUserCancel" object:nil];
        }else if ([strMsg isEqualToString:@"支付失败"]){
            [MBProgressHUD showError:@"支付失败"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wechatPayFaild" object:nil];
        }
        [UIPasteboard removePasteboardWithName:@"dataToZeji"];
        tmp = YES;
    }else{
        tmp = NO;
    }
    return  tmp;
}
-(NSDictionary*)returnDictionaryWithDataPath:(NSData*)data

{
    
    //  NSData* data = [[NSMutableData alloc]initWithContentsOfFile:path]; 拿路径文件
    
    NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    
    NSDictionary* myDictionary = [unarchiver decodeObjectForKey:@"talkData"];
    
    [unarchiver finishDecoding];
    
    return myDictionary;
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    bool tmp = NO;
    tmp = [WXApi handleOpenURL:url delegate:self];
    if (tmp == NO) {
        tmp = [self zejipay:url];
    }
    return tmp;
}

- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
//    应用在前台收到通知
    NSLog(@"========%@", notification);
}
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    //点击通知进入应用 NSLog(@"response:%@", response);
}

@end
