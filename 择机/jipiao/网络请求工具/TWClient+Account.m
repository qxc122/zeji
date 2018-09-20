//
//  TWClient+Account.m
//  wallet
//
//  Created by xinxin on 15/11/16.
//  Copyright © 2015年 xingxing. All rights reserved.
//


#import "DefineURL.h"
#import "TWClient+Account.h"

@implementation TWClient (Account)
//发送短信验证码
- (void)sendVerifyCodeWithmobile:(NSString *)mobile type:(NSString *)type success:(RequestSuccess)successBlock failure:(RequestFailure)failureBlock{
    NSDictionary *parameters = @{
                                 @"mobile":mobile,
                                 @"type":type,
                                 };
    [[TWClient sharedInstance]postWithPath:REQUESTURLsendVerifyCode parameters:parameters success:successBlock failure:failureBlock];
}
- (void)loginWithmobile:(NSString *)mobile verifyCode:(NSString *)verifyCode success:(RequestSuccess)successBlock failure:(RequestFailure)failureBlock{
    NSDictionary *parameters = @{
                                 @"mobile":mobile,
                                 @"verifyCode":verifyCode,
                                 };
    [[TWClient sharedInstance]postWithPath:REQUESTURLlogin parameters:parameters success:successBlock failure:failureBlock];
}
//微信登录
- (void)weChatLoginWithnickname:(NSString *)nickname
                       province:(NSString *)province
                           city:(NSString *)city
                         gender:(NSString *)gender
                         avatar:(NSString *)avatar  //头像
                     openIdType:(NSString *)openIdType  //类型
                        country:(NSString *)country
                         openId:(NSString *)openId
                        unionid:(NSString *)unionid
                        success:(RequestSuccess)successBlock
                        failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (nickname) {
        [parameters setValue:nickname forKey:@"nickname"];
    }
    if (province) {
        [parameters setValue:city forKey:@"province"];
    }
    if (gender) {
        [parameters setValue:gender forKey:@"gender"];
    }
    if (avatar) {
        [parameters setValue:avatar forKey:@"avatar"];
    }
    if (openIdType) {
        [parameters setValue:openIdType forKey:@"openIdType"];
    }
    if (country) {
        [parameters setValue:country forKey:@"country"];
    }
    if (openId) {
        [parameters setValue:openId forKey:@"openId"];
    }
    if (unionid) {
        [parameters setValue:unionid forKey:@"unionid"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLweChatLogin parameters:parameters success:successBlock failure:failureBlock];
}
//退出登录
- (void)logoutsuccess:(RequestSuccess)successBlock
              failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLweChatlogout parameters:nil success:successBlock failure:failureBlock];
}

@end
