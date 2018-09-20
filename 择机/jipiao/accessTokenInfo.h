//
//  accessTokenInfo.h
//  jipiao
//
//  Created by Store on 16/8/12.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>


@interface accessTokenInfo : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *accessToken;
@property (nonatomic,strong) NSString *expireTime; //失效时间
@property (nonatomic,strong) NSString *sessionKey;
@property (nonatomic,strong) NSString *sessionSecret;

@end

