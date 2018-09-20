//
//  Ticket.m
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "Ticket.h"
#import "TWClient.h"
#import "DefineURL.h"
#import "AppTools.h"
#import "ChatDemoHelper.h"
@interface Ticket ()
@property (strong, nonatomic) NSString *iszjLogin;//用户是否登录
@end

@implementation Ticket
+ (Ticket *)sharedInstance
{
    
    static Ticket *_shareInstance = nil;
    static dispatch_once_t cityTableToken;
    dispatch_once(&cityTableToken, ^{
        _shareInstance = [[Ticket alloc] init];
    });
    return _shareInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //做一些初始化的事情
    }
    return self;
}


#pragma mark - lazy init
- (NSString *)userId{
    if (!_userId) {
        _userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"TicketuserId"];
    }
    return _userId;
}
//- (NSString *)iszjLogin{
//    if (!_iszjLogin) {
//        _iszjLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"TicketisLogin"];
//    }
//    return _iszjLogin;
//}
- (BOOL)judgeIsLOgin{
    BOOL tmp = NO;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSString *state = [ud objectForKey:@"TicketisLogin"];
    if ([state isEqualToString:ZEJIIN]) {
        tmp = YES;
    }
    return tmp;
}
- (NSString *)appId
{
    if (!_appId) {
        _appId = [[NSUserDefaults standardUserDefaults] objectForKey:@"APPID"];
    }
    return _appId;
}

- (NSString *)appSerect
{
    if (!_appSerect) {
        _appSerect = [[NSUserDefaults standardUserDefaults] objectForKey:@"APPSECRET"];
    }
    return _appSerect;
}
- (userInfo *)userinfo{
    if (!_userinfo) {
        _userinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    }
    return _userinfo;
}
- (accessTokenInfo *)accessTokeninfo{
    if (!_accessTokeninfo) {
        _accessTokeninfo = [NSKeyedUnarchiver unarchiveObjectWithFile:accessTokenInfoPATH];
    }
    return _accessTokeninfo;
}
//更新userId
-(void)updateuserIdinfo:(NSString *)iszjLogin{
    _userId = iszjLogin;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:iszjLogin forKey:@"TicketuserId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
//更新登录状态
-(void)updateLogininfo:(NSString *)iszjLogin{
    _iszjLogin = iszjLogin;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:iszjLogin forKey:@"TicketisLogin"];
    [[NSUserDefaults standardUserDefaults] synchronize];

    NSString *name = nil;
    if ([iszjLogin isEqualToString:ZEJIOUT]) {  //退出
        name = ZEJILogOutsuccess;
        self.userinfo = nil;
        //删除归档文件USERINFOPATH   GRXXDATA  ZEJIKECYCJRPATH  ZEJIKEMISHUPATH
        NSFileManager *defaultManager = [NSFileManager defaultManager];
        if ([defaultManager isDeletableFileAtPath:USERINFOPATH]) {
            [defaultManager removeItemAtPath:USERINFOPATH error:nil];
        }
        if ([defaultManager isDeletableFileAtPath:GRXXDATA]) {
            [defaultManager removeItemAtPath:GRXXDATA error:nil];
        }
        if ([defaultManager isDeletableFileAtPath:ZEJIKECYCJRPATH]) {
            [defaultManager removeItemAtPath:ZEJIKECYCJRPATH error:nil];
        }
        if ([defaultManager isDeletableFileAtPath:ZEJIKEMISHUPATH]) {
            [defaultManager removeItemAtPath:ZEJIKEMISHUPATH error:nil];
        }

        [[SDImageCache sharedImageCache]removeImageForKey:ZEJIICON];
        
        [self loadOutTokefu];
    } else {    //登录
        name = ZEJILoginsuccess;
    }
    NSLog(@"sdf=%@",[NSThread currentThread]);
    NSNotification *notification =[NSNotification notificationWithName:name object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notification];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFINAME_RESETCOOKIE object:nil];
}
//更新用户头像
-(void)updateuserinfoForIcon:(NSString *)url{
    self.userinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    self.userinfo.avatar = url;
    [self storeImage:url with:ZEJIICON];
    [NSKeyedArchiver archiveRootObject:self.userinfo toFile:USERINFOPATH];
}
//更新用户信息
-(void)updateuserinfo:(userInfo *)userinfo
              success:(RequestSuccess)successBlock
              failure:(RequestFailure)failureBlock{
    if (![userinfo.avatar hasPrefix:@"http"]) {
        userinfo.avatar = [NSString stringWithFormat:@"%@/zeji-front%@",kURLAPIBase,userinfo.avatar];
    }
    self.userinfo = userinfo;

    [NSKeyedArchiver archiveRootObject:userinfo toFile:USERINFOPATH];
    [self storeImage:userinfo.avatar with:ZEJIICON];
    _userinfo = [NSKeyedUnarchiver unarchiveObjectWithFile:USERINFOPATH];
    NSLog(@"_userinfo=%@",_userinfo);
    
    [self loadHuangXingWith:userinfo.easemobId mima:HXMIMA success:successBlock failure:failureBlock];
}

- (void)loadOutTokefu{//退出环信
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] logout:YES];
        if (!error) {
            NSLog(@"退出成功");
        }
    });
}
- (void)loadHuangXingWith:(NSString *)username mima:(NSString *)password
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
        if (!isAutoLogin) {
            EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
            if (error==nil) {
                NSLog(@"登录成功  HX");
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                    successBlock(nil,@"登录成功",0);
                });
                [[EMClient sharedClient].options setIsAutoLogin:YES];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    //回调或者说是通知主线程刷新，
                    failureBlock(0,@"登录失败");
                });
                NSLog(@"登录失败 HXerror1=%@",error);
            }
        }
    });
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
/**
 *  下载图片保存到磁盘
 *
 *  @param url 图片下载地址
 *  @param key 图片保存的key
 */
- (void)storeImage:(NSString *)url with:(NSString *)key{
    SDWebImageDownloader *downloader = [SDWebImageDownloader sharedDownloader];
    [downloader downloadImageWithURL:[NSURL URLWithString:url] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
    } completed:^(UIImage *image, NSData *data, NSError *error, BOOL finished) {
        if (!error) {
            [[SDImageCache sharedImageCache] storeImage:[image cutCircleImage] forKey:key toDisk:YES];
        }
        NSNotification *notification =[NSNotification notificationWithName:ZEJIICONUPLOAD object:nil userInfo:nil];
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }];
}
//更新accessToken
- (void)updateAccessTokenInfo:(accessTokenInfo *)accessToken
{
    self.accessTokeninfo = accessToken;
    [NSKeyedArchiver archiveRootObject:accessToken toFile:accessTokenInfoPATH];

    NSDate *senddate = [NSDate date];
//    NSString *date2 = [NSString stringWithFormat:@"%ld", (long)[senddate timeIntervalSince1970]];
    [NSKeyedArchiver archiveRootObject:senddate toFile:accessTokenInfoDatePATH];
//    NSDate *oldDate = [NSKeyedUnarchiver unarchiveObjectWithFile:accessTokenInfoDatePATH];
}

//更新appid和appsecret
- (void)updateAppid:(NSString *)appid
          appSecret:(NSString *)appSecret
{
    self.appId = appid;
    self.appSerect = appSecret;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:appid forKey:@"APPID"];
    [ud setObject:appSecret forKey:@"APPSECRET"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[Ticket sharedInstance] fetchAccessToken];
    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_RESETCOOKIE object:nil];
}

- (void)RefreshTheAccessTokeninfo{
    
    [[TWClient sharedInstance]fetchAccessTokenWithAppid:self.appId success:^(id dataDict, NSString *msg, NSInteger code) {
        accessTokenInfo *data = [MTLJSONAdapter modelOfClass:[accessTokenInfo class] fromJSONDictionary:dataDict error:nil];
        [self updateAccessTokenInfo:data];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_RESETCOOKIE object:nil];
        if ([[Ticket sharedInstance]judgeIsLOgin]) {
            [[TWClient sharedInstance] fetchAccessTokensuccesssuccess:^(id dataDict, NSString *msg, NSInteger code) {
                NSLog(@"刷新逃课OK");
                [[Ticket sharedInstance]updateuserinfo:[MTLJSONAdapter modelOfClass:[userInfo class] fromJSONDictionary:dataDict error:nil] success:nil failure:nil];
                [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_RESETCOOKIE object:nil];
            } failure:^(NSInteger errorCode, NSString *msg) {
                NSLog(@"刷新逃课失败");
                [self RefreshTheAccessTokeninfo];
            }];
        }
    } failure:^(NSInteger errorCode, NSString *msg) {
//        [self RefreshTheAccessTokeninfo];
        
        [self performSelector:@selector(fetchAccessToken) withObject:nil afterDelay:0.5f];
        NSLog(@"获取accessToken 失败");
    }];
}
//判断是否存在appid和appsecret
- (BOOL)judgeIsSaveAppidAndAppSecret
{
    if (self.appId.length != 0 && self.appSerect.length != 0) {
        return YES;
    }
    return NO;
}

- (void)fetchAccessToken{
    __weak typeof(self) weakSelf = self;
    [[TWClient sharedInstance]fetchAccessTokenWithAppid:self.appId success:^(id dataDict, NSString *msg, NSInteger code) {
        accessTokenInfo *data = [MTLJSONAdapter modelOfClass:[accessTokenInfo class] fromJSONDictionary:dataDict error:nil];
        [weakSelf updateAccessTokenInfo:data];
        if ([AppTools isFirstStart]) {
            [weakSelf getALLpramses];
        }
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_RESETCOOKIE object:nil];
        [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_REGETDATA object:nil];
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"获取accessToken 失败");
        [weakSelf performSelector:@selector(fetchAccessToken) withObject:nil afterDelay:0.5f];
//        [[Ticket sharedInstance] fetchAccessToken];
    }];
}

- (void)getALLpramses{ //后去全局参数
    [[TWClient sharedInstance]getGlobalParamssuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSLog(@"在首页  获取全局参数获取OK");
        GlobalParams *arrryDes = [MTLJSONAdapter modelOfClass:[GlobalParams class] fromJSONDictionary:dataDict error:nil];
        [NSKeyedArchiver archiveRootObject:arrryDes toFile:ALLHDATA];
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"在首页  获取全局参数获取失败");
    }];
}

//登录客服
- (void)loginServer{
//        EMClient *easemob = [EMClient sharedClient];
//        if (!easemob.isLoggedIn || ([_username length] == 0 || [_password length] == 0)) {
//            if ([_username length] == 0 || [_password length] == 0) {
//                UIDevice *device = [UIDevice currentDevice];//创建设备对象
//                NSString *deviceUID = [[NSString alloc] initWithString:[[device identifierForVendor] UUIDString]];
//                if ([deviceUID length] == 0) {
//                    CFUUIDRef uuid = CFUUIDCreate(NULL);
//                    if (uuid)
//                    {
//                        deviceUID = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
//                        CFRelease(uuid);
//                    }
//                }
//                _username = [deviceUID stringByReplacingOccurrencesOfString:@"-" withString:@""];
//                _password = @"123456";
//                [easemob.chatManager asyncRegisterNewAccount:_username password:_password withCompletion:^(NSString *username, NSString *password, EMError *error) {
//                    if (!error || error.errorCode == EMErrorServerDuplicatedAccount) {
//                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                        [userDefaults setObject:@"username" forKey:_username];
//                        [userDefaults setObject:@"password" forKey:_password];
//                        [easemob.chatManager asyncLoginWithUsername:_username password:_password];
//                    }
//                } onQueue:nil];
//            }
//            else{
//                [easemob.chatManager asyncLoginWithUsername:_username password:_password];
//            }
//        }
}

@end
