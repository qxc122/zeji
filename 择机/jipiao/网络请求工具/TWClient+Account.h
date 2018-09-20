//
//  TWClient+Account.h
//  wallet
//
//  Created by xinxin on 15/11/16.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#import "TWClient.h"

@interface TWClient (Account)
//发送短信验证码
- (void)sendVerifyCodeWithmobile:(NSString *)mobile
                          type:(NSString *)type
                         success:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock;
//验证码登录
- (void)loginWithmobile:(NSString *)mobile
                        verifyCode:(NSString *)verifyCode
                         success:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock;
//微信登录
- (void)weChatLoginWithnickname:(NSString *)nickname
             province:(NSString *)province
                city:(NSString *)city
                gender:(NSString *)gender
                avatar:(NSString *)avatar
                openIdType:(NSString *)openIdType
                country:(NSString *)country
                     openId:(NSString *)openId
                        unionid:(NSString *)unionid
                success:(RequestSuccess)successBlock
                failure:(RequestFailure)failureBlock;
//退出登录
- (void)logoutsuccess:(RequestSuccess)successBlock
              failure:(RequestFailure)failureBlock;

@end
