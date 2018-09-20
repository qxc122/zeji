//
//  TWWechatPayManager.h
//  TempusMall
//
//  Created by xingxing on 15/8/10.
//  Copyright (c) 2015年 xingxing. All rights reserved.
//
/**
 *  微信支付管理类
 */
#import <Foundation/Foundation.h>

//支付类型
typedef NS_ENUM(NSInteger, TWPayType)
{
    kPayTypeWechat = 1    //微信支付
};

@interface TWWechatPayManager : NSObject

@property (strong, nonatomic) NSString          *orderPirce;
@property (strong, nonatomic) NSString          *payType;

+ (TWWechatPayManager *)sharedInstance;

/**
 *  注册微信
 */
- (void)registerWeChat;


- (void)wechatpayWithPrepayInfo:(NSDictionary *)info;

- (void)shareTOWXsceneWithinfo:(NSDictionary *)info;

@end
