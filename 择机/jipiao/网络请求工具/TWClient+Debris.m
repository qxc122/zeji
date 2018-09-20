//
//  TWClient+Debris.m
//  jipiao
//
//  Created by Store on 16/8/11.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TWClient+Debris.h"
#import "DefineURL.h"
#import "DefineCommon.h"

@implementation TWClient (Debris)
//App版本更新
- (void)appUpdatesuccess:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock{
    
    NSString *verCode = app_Version;
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (verCode) {
        [parameters setValue:verCode forKey:@"verCode"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLappUpdate parameters:nil success:successBlock failure:failureBlock];
}
//首页应用列表获取
- (void)getCooperationAppsuccess:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLgetCooperationApp parameters:nil success:successBlock failure:failureBlock];
}
//左侧菜单查询
- (void)queryMenusuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLqueryMenu parameters:nil success:successBlock failure:failureBlock];
}
//获取我的信息
- (void)getMyInfosuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLgetMyInfo parameters:nil success:successBlock failure:failureBlock];
}
//全局参数获取
- (void)getGlobalParamssuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLgetGlobalParams parameters:nil success:successBlock failure:failureBlock];
}

//修改我的信息
- (void)MyInfoModifyWithuserName:(NSString *)userName
                          mobile:(NSString *)mobile
                          certNo:(NSString *)certNo
                         success:(RequestSuccess)successBlock
                         failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (userName) {
        [parameters setValue:userName forKey:@"userName"];
    }
    if (mobile) {
        [parameters setValue:mobile forKey:@"mobile"];
    }
    if (certNo) {
        [parameters setValue:certNo forKey:@"certNo"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLMyInfoModify parameters:parameters success:successBlock failure:failureBlock];
}


//查询航班查询记录
- (void)FlightQueryHistoryWithpageNo:(NSString *)pageNo
                success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock{
    NSDictionary *parameters = @{
                                 @"pageNo":pageNo,
                                 };
    [[TWClient sharedInstance]postWithPath:REQUESTURLFlightQueryHistory parameters:parameters success:successBlock failure:failureBlock];
}
//增加航班查询记录
- (void)AddFlightQueryWithdepDate:(NSString *)depDate
                        journeyType:(NSString *)journeyType
                        depCityCode:(NSString *)depCityCode
                        arrCityCode:(NSString *)arrCityCode
                         success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock{
    NSDictionary *parameters = @{
                                 @"depDate":depDate,
                                 @"journeyType":journeyType,
                                 @"depCityCode":depCityCode,
                                 @"arrCityCode":arrCityCode,
                                 };
    [[TWClient sharedInstance]postWithPath:REQUESTURLAddFlightQuery parameters:parameters success:successBlock failure:failureBlock];
}
//删除航班查询记录
- (void)CleanFlightQuerysuccess:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock{
    [[TWClient sharedInstance]postWithPath:REQUESTURLCleanFlightQuery parameters:nil success:successBlock failure:failureBlock];
}
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
                        failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (contactType) {
        [parameters setValue:contactType forKey:@"contactType"];
    }
    if (mobile) {
        [parameters setValue:mobile forKey:@"mobile"];
    }
    if (name) {
        [parameters setValue:name forKey:@"name"];
    }
    if (certType) {
        [parameters setValue:certType forKey:@"certType"];
    }
    if (certNo) {
        [parameters setValue:certNo forKey:@"certNo"];
    }
    if (birthday) {
        [parameters setValue:birthday forKey:@"birthday"];
    }
    if (friendFlag) {
        [parameters setValue:friendFlag forKey:@"friendFlag"];
    }
    
    if (surname) {
        [parameters setValue:surname forKey:@"surname"];
    }
    if (enName) {
        [parameters setValue:enName forKey:@"enName"];
    }
    if (sex) {
        [parameters setValue:sex forKey:@"sex"];
    }
    if (nationality) {
        [parameters setValue:nationality forKey:@"nationality"];
    }
    if (expireDate) {
        [parameters setValue:expireDate forKey:@"expireDate"];
    }
    if (defaultFlag) {
        [parameters setValue:defaultFlag forKey:@"defaultFlag"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLaddContact parameters:parameters success:successBlock failure:failureBlock];
}
//联系人列表查询
- (void)qryContactWithcontactType:(NSString *)contactType //联系人类型
                         friendFlag:(NSString *)friendFlag //好友标志
                            success:(RequestSuccess)successBlock
                            failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (contactType) {
        [parameters setValue:contactType forKey:@"contactType"];
    }
    if (friendFlag) {
        [parameters setValue:friendFlag forKey:@"friendFlag"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLqryContact parameters:parameters success:successBlock failure:failureBlock];
}
//联系人详细信息查询
- (void)qryContactWitheasemobId:(NSString *)easemobId //联系人id
                          success:(RequestSuccess)successBlock
                          failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (easemobId) {
        [parameters setValue:easemobId forKey:@"easemobId"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLcontactDetailQuery parameters:parameters success:successBlock failure:failureBlock];
}
//获取用户环信信息
- (void)REQUESTURLgetEasemobInfoWitheasemobId:(NSString *)easemobId //联系人id
                        success:(RequestSuccess)successBlock
                        failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (easemobId) {
//        if ([easemobId hasPrefix:@"dev"]) {
//            easemobId  = [easemobId stringByReplacingOccurrencesOfString:@"dev" withString:@"DEV"];
//        }
        [parameters setValue:easemobId forKey:@"easemobId"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLgetEasemobInfo parameters:parameters success:successBlock failure:failureBlock];
}

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
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (userId) {
        [parameters setValue:userId forKey:@"userId"];
    }
    if (othUserId) {
        [parameters setValue:othUserId forKey:@"othUserId"];
    }
    if (mobile) {
        [parameters setValue:mobile forKey:@"mobile"];
    }
    if (name) {
        [parameters setValue:name forKey:@"name"];
    }
    if (sex) {
        [parameters setValue:sex forKey:@"sex"];
    }
    if (certType) {
        [parameters setValue:certType forKey:@"certType"];
    }
    if (certNo) {
        [parameters setValue:certNo forKey:@"certNo"];
    }
    if (contactId) {
        [parameters setValue:contactId forKey:@"contactId"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLeditContact parameters:parameters success:successBlock failure:failureBlock];
}
//删除联系人
- (void)deleteContactWithcontactType:(NSString *)contactType
                      contactId:(NSNumber *)contactId
                        success:(RequestSuccess)successBlock
                        failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (contactType) {
        [parameters setValue:contactType forKey:@"contactType"];
    }
    if (contactId) {
        [parameters setValue:contactId forKey:@"contactId"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLdeleteContact parameters:parameters success:successBlock failure:failureBlock];
}
//优惠码充值
- (void)couponCodeRechargeWithcouponCode:(NSString *)couponCode
                             success:(RequestSuccess)successBlock
                             failure:(RequestFailure)failureBlock{
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (couponCode) {
        [parameters setValue:couponCode forKey:@"couponCode"];
    }
    [[TWClient sharedInstance]postWithPath:REQUESTURLcouponCodeRecharge parameters:parameters success:successBlock failure:failureBlock];
}
@end
