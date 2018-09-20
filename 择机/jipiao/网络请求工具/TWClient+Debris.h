//
//  TWClient+Debris.h
//  jipiao
//
//  Created by Store on 16/8/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TWClient.h"

@interface TWClient (Debris)

//App版本更新
- (void)appUpdatesuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock;
//首页应用列表获取
- (void)getCooperationAppsuccess:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock;
//左侧菜单查询
- (void)queryMenusuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock;
//获取我的信息
- (void)getMyInfosuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock;

//全局参数获取
- (void)getGlobalParamssuccess:(RequestSuccess)successBlock
                       failure:(RequestFailure)failureBlock;

//修改我的信息
- (void)MyInfoModifyWithuserName:(NSString *)userName
                            mobile:(NSString *)mobile
                            certNo:(NSString *)certNo
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock;

//联系人列表查询
- (void)qryContactWithcontactType:(NSString *)contactType //联系人类型
                          friendFlag:(NSString *)friendFlag //好友标志
                         success:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock;
//查询航班查询记录
- (void)FlightQueryHistoryWithpageNo:(NSString *)pageNo
                             success:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;
//增加航班查询记录
- (void)AddFlightQueryWithdepDate:(NSString *)depDate
                      journeyType:(NSString *)journeyType
                      depCityCode:(NSString *)depCityCode
                      arrCityCode:(NSString *)arrCityCode
                          success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;
//删除航班查询记录
- (void)CleanFlightQuerysuccess:(RequestSuccess)successBlock
                        failure:(RequestFailure)failureBlock;
//新增联系人
- (void)addContactWithcontactType:(NSString *)contactType
                           mobile:(NSString *)mobile
                             name:(NSString *)name
                          surname:(NSString *)surname
                           enName:(NSString *)enName
                              sex:(NSString *)sex
                      nationality:(NSString *)nationality
                         certType:(NSString *)certType
                           certNo:(NSString *)certNo
                         birthday:(NSString *)birthday
                       expireDate:(NSString *)expireDate
                      defaultFlag:(NSString *)defaultFlag
                       friendFlag:(NSString *)friendFlag
                          success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock;
//修改联系人
- (void)editContactWithuserId:(NSString *)userId
                    othUserId:(NSString *)othUserId
                       mobile:(NSString *)mobile
                         name:(NSString *)name
                          sex:(NSString *)sex
                     certType:(NSString *)certType
                       certNo:(NSString *)certNo
                    contactId:(NSString *)contactId
                      success:(RequestSuccess)successBlock
                      failure:(RequestFailure)failureBlock;
//删除联系人
- (void)deleteContactWithcontactType:(NSString *)contactType
                           contactId:(NSNumber *)contactId
                             success:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock;

//联系人详细信息查询
- (void)qryContactWitheasemobId:(NSString *)easemobId //联系人id
                        success:(RequestSuccess)successBlock
                        failure:(RequestFailure)failureBlock;
//获取用户环信信息
- (void)REQUESTURLgetEasemobInfoWitheasemobId:(NSString *)easemobId   //环信id
                                      success:(RequestSuccess)successBlock
                                      failure:(RequestFailure)failureBlock;
//优惠码充值
- (void)couponCodeRechargeWithcouponCode:(NSString *)couponCode
                                 success:(RequestSuccess)successBlock
                                 failure:(RequestFailure)failureBlock;
@end
