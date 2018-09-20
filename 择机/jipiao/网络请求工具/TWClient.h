//
//  TWClient.h
//  wallet
//
//  Created by xingxing on 15/11/9.
//  Copyright © 2015年 xingxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFURLRequestSerialization.h>
typedef void (^RequestLoading)(NSProgress *progress);
typedef void (^RequestSuccess)(id dataDict, NSString *msg, NSInteger code);
typedef void (^RequestFailure)(NSInteger errorCode, NSString *msg);

@interface TWClient : NSObject

+ (TWClient *)sharedInstance;

/**
 *  post 请求方式
 *
 *  @param path         地址
 *  @param parameters   参数
 */
- (void)postWithPath:(NSString *)path
          parameters:(NSDictionary *)parameters
             success:(RequestSuccess)successBlock
             failure:(RequestFailure)failureBlock;
/**
 *  获取Appid跟AppSerect
 *
 *  @param deviceID   设备ID
 */
- (void)appIdApplysuccess:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock;
/**
 *  获取accessToken
 *
 *  @param appid        应用id
 */
- (void)fetchAccessTokenWithAppid:(NSString *)appid
                          success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;
/**
 *  刷新登录验证票
 *
 *  @param ticket       验证票
 *  @param timestamp    时间戳
 *  @param successBlock <#successBlock description#>
 *  @param failureBlock <#failureBlock description#>
 */
- (void)fetchAccessTokensuccesssuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock;
//上传头像
- (void)avatarUploadWithavatarFile:(UIImage *)avatarFile
                          progress:(RequestLoading)progressBlock
                           success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;
@end
