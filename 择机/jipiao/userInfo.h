//
//  userInfo.h
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface userInfo : MTLModel<MTLJSONSerializing> //NSCoding
@property (nonatomic,strong) NSString *displayName;//显示登录名
@property (nonatomic,strong) NSString *authenTicket; //验证票
@property (nonatomic,strong) NSString *authenUserId;//验证用户Id
@property (nonatomic,strong) NSString *loginTime;//登录时间
@property (nonatomic,strong) NSString *avatar;//头像吧
@property (nonatomic,strong) NSString *easemobId;//环信唯一号
@property (nonatomic,strong) NSString *phone;//手机号
@end
