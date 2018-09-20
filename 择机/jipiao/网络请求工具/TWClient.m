//
//  TWClient.m
//  wallet
//
//  Created by xingxing on 15/11/9.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#import "DefineEnum.h"
#import "ticket.h"
#import "DefineURL.h"
#import "TWClient.h"
#import "AFNetworking.h"
#import "HeaderTotal.h"
#import "MBProgressHUD.h"

@interface TWClient ()

@property (strong, nonatomic) NSString *baseURLStr;
@property (assign, nonatomic) BOOL isReachable;

@end

@implementation TWClient

+ (TWClient *)sharedInstance
{
    static TWClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    instance.baseURLStr = kURLAPIBase;
    return instance;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isReachable = YES;
        [self reachability];
    }
    return self;
}
- (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(RequestSuccess)successBlock
             failure:(RequestFailure)failureBlock
{
    if (!self.isReachable) {
//        [MBProgressHUD showSuccess:@"请检查您的网络设置"];
        failureBlock(KRespondCodeFail,@"请检查您的网络设置");
        return;
    }
    NSDictionary *paramstmp = @{
                                @"channel": ZJCHANNEL,
                                @"serviceCode": ZJserviceCode,
                                @"localDateTime":[NSString returntimestamp],
                                @"userId":[Ticket sharedInstance].userinfo.authenUserId?[Ticket sharedInstance].userinfo.authenUserId:@"qccuserId",
                                @"externalReferenceNo": ZJuserReferenceNo,
                                @"userReferenceNo": ZJexternalReferenceNo,
                                @"stepCode": ZJstepCode,
                                @"accessSource": ZJaccessSource,
                                @"accessSourceType": ZJaccessSourceType,
                                @"version": ZJversion,
                                @"accessToken":[Ticket sharedInstance].accessTokeninfo.accessToken?[Ticket sharedInstance].accessTokeninfo.accessToken:@"qccaccessToken",
                                };
    NSMutableDictionary *params;
    if (parameters) {
        params = [parameters mutableCopy];
    } else {
        params = [[NSMutableDictionary alloc]init];
    }
    [params setObject:paramstmp forKey:@"sessionContext"];

    NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.baseURLStr, path];
//    NSLog(@"urlStr=%@", parameters[@"service"]);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10.0f;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json", nil];
    [manager POST:urlStr parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"path=%@请求OK",path);
        if ([path isEqualToString:REQUESTURLeditContact] || [path isEqualToString:REQUESTURLdeleteContact]) { //修改联系人 和 删除联系人没有应答报文 所以
            successBlock(nil, @"操作成功", 0);
        }else{
            [self parseResponseData:responseObject
                            success:^(id dataDict, NSString *msg, NSInteger code) {
                                successBlock(dataDict, msg, code);
                            }failure:^(NSInteger errorCode, NSString *msg) {
                                failureBlock(errorCode, msg);
                            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(KRespondCodeFail,REQUESTFAIL);
        NSLog(@"path=%@请求失败",path);
    }];
}

//验证返回数据是否正确
- (void)parseResponseData:(id)responseData
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock
{
    NSDictionary *jsonRootObject = (NSDictionary *)responseData;
    
    if (jsonRootObject == nil) {
        failureBlock(kRespondCodeNotJson, @"返回数据不是JSON格式");
    }else {
        NSDictionary *transactionStatus = [jsonRootObject objectForKey:@"transactionStatus"];
        NSString *status = [transactionStatus objectForKey:@"errorCode"];
        NSString *msg = [transactionStatus objectForKey:@"replyText"];
        id dataJson = jsonRootObject;

        if ([status isEqualToString:@"0"] ) {
            successBlock(dataJson, msg, [status integerValue]);
        } else {
            NSString *replyCode = [transactionStatus objectForKey:@"replyCode"];
            if ([replyCode isEqualToString:@"100008"]) {
                [[Ticket sharedInstance] RefreshTheAccessTokeninfo];
                failureBlock([replyCode integerValue], @"请重新操作一次");
                NSLog(@"status");
            } else if ([replyCode isEqualToString:@"100005"]) {
                [[TWClient sharedInstance] appIdApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
                    NSLog(@"首次获取appid成功");
                    [[Ticket sharedInstance] updateAppid:dataDict[@"appId"] appSecret:dataDict[@"appSecret"]];
                    [[Ticket sharedInstance] fetchAccessToken];
                    [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFINAME_RESETCOOKIE object:nil];
                }failure:^(NSInteger errorCode, NSString *msg) {
                    NSLog(@"获取appid失败 %@", msg);
                    //TODO:
                }];
                
                failureBlock([replyCode integerValue], @"请重新操作一次");
                NSLog(@"status");
            }else{
                failureBlock([replyCode integerValue], msg);
                NSLog(@"replyCode");
            }
        }
    }
}

- (NSString *)diyGetRequestURLWithParameters:(NSDictionary *)params
{
    NSMutableString *urlStr = [[NSMutableString alloc] init];
    for (NSString *key in params.allKeys) {
        NSString *value = params[key];
        [urlStr appendString:[NSString stringWithFormat:@"%@=%@&", key, value]];
    }
    if (urlStr.length != 0) {
        [urlStr deleteCharactersInRange:NSMakeRange(urlStr.length - 1, 1)];
    }

    return urlStr;
}
/**
 *  获取Appid跟AppSerect
 *
 *  @param deviceID   设备ID
 */
- (void)appIdApplysuccess:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock{
    NSDictionary *params = @{
                             @"deviceId" : [OpenUDID value],
                             };
    [[TWClient sharedInstance]postWithPath:REQUESTURLappIdApply parameters:params success:successBlock failure:failureBlock];
}
/**
 *  获取accessToken
 *
 *  @param appid        应用id
 */
- (void)fetchAccessTokenWithAppid:(NSString *)appid
                          success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock{
    
    NSString *timeSp = [NSString returntimestampChuo];
//    NSDateFormatter *formatter =[[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMddHHmmss"];
//    NSDate *datenow = [NSDate date];
//    NSString *timetmp = @"2016812174021";//[formatter stringFromDate:datenow];//现在时间
//
//    NSString *timeSp = @"1470994821";//[NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];

    NSString *signStr = [NSString stringWithFormat:@"%@%@%@", [OpenUDID value], [Ticket sharedInstance].appSerect,timeSp];
//    NSString *signStr2 = signStr;
    signStr = [NSString md5HexDigest:signStr];
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    if ([Ticket sharedInstance].appId) {
        [params setObject:[Ticket sharedInstance].appId forKey:@"appId"];
    }
    [params setObject:[OpenUDID value] forKey:@"deviceId"];
    [params setObject:timeSp forKey:@"timestamp"];
    [params setObject:signStr forKey:@"sign"];
    
    
//    NSDictionary *params = @{
//                             @"deviceId" : [OpenUDID value],
//                             @"timestamp" : timeSp,
//                             @"appId" : [Ticket sharedInstance].appId,
//                             @"sign" :signStr,
//                             };
    [[TWClient sharedInstance]postWithPath:REQUESTURLtokenApply parameters:params success:successBlock failure:failureBlock];
}
/**
 *  刷新登录验证票
 *
 *  @param ticket       验证票
 *  @param timestamp    时间戳
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 */
- (void)fetchAccessTokensuccesssuccess:(RequestSuccess)successBlock
                               failure:(RequestFailure)failureBlock{
    NSDictionary *params = @{
                             @"ticket" : [Ticket sharedInstance].userinfo.authenTicket,
                             @"timestamp" : [NSString returntimestampChuo],
                             };
    [[TWClient sharedInstance]postWithPath:REQUESTURLrefreshLogin parameters:params success:successBlock failure:failureBlock];
}

//上传头像 REQUESTURLavatarUpload
- (void)avatarUploadWithavatarFile:(UIImage *)avatarFile
                           progress:(RequestLoading)progressBlock
                           success:(RequestSuccess)successBlock
                    failure:(RequestFailure)failureBlock{
    NSDictionary *paramstmp1 = @{
                                @"channel": ZJCHANNEL,
                                @"serviceCode": ZJserviceCode,
                                @"localDateTime":[NSString returntimestamp],
                                @"userId":[Ticket sharedInstance].userinfo.authenUserId?[Ticket sharedInstance].userinfo.authenUserId:@"qccuserId",
                                @"externalReferenceNo": ZJexternalReferenceNo,
                                @"userReferenceNo": ZJuserReferenceNo,
                                @"stepCode": ZJstepCode,
                                @"accessSource": ZJaccessSource,
                                @"accessSourceType": ZJaccessSourceType,
                                @"version": ZJversion,
                                @"accessToken":[Ticket sharedInstance].accessTokeninfo.accessToken?[Ticket sharedInstance].accessTokeninfo.accessToken:@"qccaccessToken",
                                };
        NSString *tmp1 = [NSString dictionaryToJson:paramstmp1];
    
    AFHTTPSessionManager *manager2 = [AFHTTPSessionManager manager];
    manager2.responseSerializer = [AFJSONResponseSerializer serializer];
    manager2.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json",@"text/html", nil];
//    manager2.requestSerializer = [AFJSONRequestSerializer serializer];
    
    //2.上传文件
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:tmp1, @"sessionContext", nil , nil];
    [manager2 POST:[kURLAPIBase stringByAppendingString:REQUESTURLavatarUpload] parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *imageData = UIImageJPEGRepresentation(avatarFile,0.5);//进行图片压缩
//        NSString *encodedImageStr = [imageData base64Encoding];//进行64位转码转为字符串
        //上传文件参数
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"avatarFile.png" mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //打印上传进度
        progressBlock(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功
        NSLog(@"path=%@请求OK",REQUESTURLavatarUpload);
        [self parseResponseData:responseObject
                        success:^(id dataDict, NSString *msg, NSInteger code) {
                            successBlock(dataDict, msg, code);
                        }failure:^(NSInteger errorCode, NSString *msg) {
                            failureBlock(errorCode, msg);
                        }];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //请求失败  
        failureBlock(KRespondCodeFail, REQUESTFAIL);
        NSLog(@"path=%@请求失败",REQUESTURLavatarUpload);
    }];
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (NSString *)ret32bitString
{
    char data[32];
    for (int x = 0; x < 32; data[x++] = (char)('A' + (arc4random_uniform(26))))
        ;
    return [[NSString alloc] initWithBytes:data length:32 encoding:NSUTF8StringEncoding];
}

- (void)reachability
{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
    // __weak typeof(self) weakSelf = self;
    static NSInteger tmp = 0;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.isReachable = [[AFNetworkReachabilityManager sharedManager]isReachable];
        if (self.isReachable) {
            if (tmp!=0) {
                [MBProgressHUD showSuccess:@"网络已连接"];
            }
        } else {
            [MBProgressHUD showError:@"请检查您的网络设置"];
        }
        tmp++;
    }];
}
@end
