//
//  WechatManager.h
//  wallet
//
//  Created by xinxin on 15/11/21.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^fetchwccodesuccess)(NSDictionary *dic);

@interface WechatManager : NSObject

+(WechatManager *)sharedInstance;

-(void)wechatGetcode:(NSString *)code andsuccess:(fetchwccodesuccess)success;

@end
