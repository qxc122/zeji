//
//  accessTokenInfo.m
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "accessTokenInfo.h"

@implementation accessTokenInfo
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"accessToken" : @"accessToken",
             @"expireTime" : @"expireTime",
             @"sessionKey" : @"sessionKey",
             @"sessionSecret" : @"sessionSecret",
             };
}
@end
