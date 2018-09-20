//
//  Ticket.h
//  jipiao
//
//  Created by Store on 16/8/10.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderTotal.h"
#import "accessTokenInfo.h"
#import "userInfo.h"
#import "DefineEnum.h"
#import "DefineCommon.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface Ticket : NSObject
+(Ticket *)sharedInstance;

@property (strong, nonatomic) NSString *userId;//用户编号
@property (strong, nonatomic) NSString *appId;//唯一appId
@property (strong, nonatomic) NSString *appSerect; //用于对数据进行加密

@property (strong, nonatomic) accessTokenInfo *accessTokeninfo;//访问令牌信息
@property (strong, nonatomic) userInfo *userinfo;//登录后获取的信息

//更新登录状态
-(void)updateLogininfo:(NSString *)iszjLogin;
- (BOOL)judgeIsLOgin;//判断是否登录
- (void)updateAppid:(NSString *)appid
          appSecret:(NSString *)appSecret;
//更新用户头像
-(void)updateuserinfoForIcon:(NSString *)url;
//更新用户信息
-(void)updateuserinfo:(userInfo *)userinfo  success:(RequestSuccess)successBlock
              failure:(RequestFailure)failureBlock;
//首次启动需要获取appid、appsecret
- (BOOL)judgeIsSaveAppidAndAppSecret;
//获取token
- (void)fetchAccessToken;


//刷新AccessTokeninfo
- (void)RefreshTheAccessTokeninfo;
@end
