//
//  TWWechatPayManager.m
//  TempusMall
//
//  Created by xingxing on 15/8/10.
//  Copyright (c) 2015年 xingxing. All rights reserved.
//

#import "DefineSDKKey.h"
#import "HeaderTotal.h"
#import "TWWechatPayManager.h"
#import "WXApi.h"
#import "payRequsestHandler.h"

@implementation TWWechatPayManager

+ (TWWechatPayManager *)sharedInstance
{
    static TWWechatPayManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)registerWeChat
{
    //向微信注册
    [WXApi registerApp:WechatAppID withDescription:@""];
}

- (void)wechatpayWithPrepayInfo:(NSDictionary *)info
{
    if (![self verifySignWithPrepayInfo:info]) {
        if (![NSThread isMainThread]) {
            dispatch_sync(dispatch_get_main_queue(), ^(){
                [MBProgressHUD showError:@"签名验证失败" toView:[UIApplication sharedApplication].keyWindow];
            });
        }else{
            [MBProgressHUD showError:@"签名验证失败" toView:[UIApplication sharedApplication].keyWindow];
        }
        NSLog(@"签名验证失败");
        return;
    }
    NSString *package, *time_stamp, *nonce_str;
    //设置支付参数
    time_t now;
    time(&now);
    time_stamp = [NSString stringWithFormat:@"%ld", now];
    nonce_str = [WXUtil md5:time_stamp];
    package = @"Sign=WXPay";
    payRequsestHandler *handler = [[payRequsestHandler alloc] init];

    NSString  *appid = info[@"appId"];
    NSString  *MCH_IDStr;
    if ([appid isEqualToString:WechatAppID]) {
        MCH_IDStr = MCH_ID;
        [handler init:WechatAppID  mch_id:MCH_ID ];
        //设置密钥
        [handler setKey:PARTNER_ID];
        
    }else if ([appid isEqualToString:WechatAppIDOther]){
         MCH_IDStr = MCH_IDOther;
        [handler init:WechatAppIDOther  mch_id:MCH_IDOther ];
        //设置密钥
        [handler setKey:PARTNER_IDOther];
    }
    if (!appid || !MCH_IDStr) {
        [MBProgressHUD showError:@"缺少参数"];
        return;
    }
    
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    [signParams setObject:appid forKey:@"appid"];
    [signParams setObject:nonce_str forKey:@"noncestr"];
    [signParams setObject:package forKey:@"package"];
    [signParams setObject:MCH_IDStr forKey:@"partnerid"];
    [signParams setObject:time_stamp forKey:@"timestamp"];
    [signParams setObject:info[@"prepayId"] forKey:@"prepayid"];

    NSString *localSign = [handler createMd5Sign:signParams];

    //调起微信支付
    PayReq *req = [[PayReq alloc] init];
    req.openID =appid;
    req.partnerId = MCH_IDStr;
    req.prepayId = info[@"prepayId"];
    req.nonceStr = nonce_str;
    req.timeStamp = time_stamp.intValue;
    req.package = package;
    req.sign = localSign;
    [WXApi sendReq:req];
}

//验证签名
- (BOOL)verifySignWithPrepayInfo:(NSDictionary *)info
{
    NSString *prepayID = info[@"prepayId"];
    if ([prepayID isKindOfClass:[NSNull class]]) {
        return NO;
    }
    
    NSMutableString *signStr = [[NSMutableString alloc] init];
    [signStr appendString:[Ticket sharedInstance].appSerect];
    [signStr appendString:self.orderPirce];
    [signStr appendString:self.payType];
    [signStr appendString:info[@"orderId"]];
    [signStr appendString:prepayID];
    [signStr appendString:info[@"timestamp"]];
    [signStr appendString:info[@"nonestr"]];
    [signStr appendString:[Ticket sharedInstance].accessTokeninfo.sessionSecret];
    
    NSString *sign = [[WXUtil md5:signStr] lowercaseString];
    NSString *responseSign = info[@"sign"];
    if ([sign isEqualToString:responseSign]) {
        return YES;
    }
    else {
        //TODO:  等待
        return YES;
    }
}

//客户端提示信息
- (void)alert:(NSString *)title msg:(NSString *)msg
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];

    [alter show];
}
- (void)shareTOWXsceneWithinfo:(NSDictionary *)info{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = info[@"title"];
    message.description = info[@"text"];
    [message setThumbImage:[UIImage imageNamed:@"img_logo_02"]];
    
    WXWebpageObject *webpageObject = [WXWebpageObject object];
    webpageObject.webpageUrl = info[@"tirgeturl"];
    message.mediaObject = webpageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.message = message;
    req.scene = (int)[info[@"type"] integerValue];
    [WXApi sendReq:req];
}
@end
