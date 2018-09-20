//
//  myinfoData.h
//  jipiao
//
//  Created by Store on 16/8/17.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>
@class flyCreditInfoData;

@interface myinfoData : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *certType;
@property (nonatomic,strong) NSString *certNo;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,strong) flyCreditInfoData *flyCreditInfo;
@property (nonatomic,strong) NSMutableArray *passengerInfos;  //常用乘机人
@property (nonatomic,strong) NSMutableArray *secretaryInfos;  //秘书
@property (nonatomic,strong) NSString *realnameStatus;//实名状态	"0：未实名1：已实名"
@property (nonatomic,strong) NSString *registerType;//"00：手机注册01：微信注册"
@end

@interface flyCreditInfoData : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *flylevel;
@property (nonatomic,strong) NSString *totalFlight;
@property (nonatomic,strong) NSString *totalMileage;
@property (nonatomic,strong) NSString *creditLimit;
@end

@interface contactinformation : MTLModel<MTLJSONSerializing>
//@property (nonatomic,strong) NSString *contactType;
@property (nonatomic,strong) NSString *userName;//用户名
@property (nonatomic,strong) NSString *certType;//证件类型
@property (nonatomic,strong) NSString *certNo;//证件号码
@property (nonatomic,strong) NSString *mobile;//手机号码
@property (nonatomic,strong) NSString *contactId;//联系人iD
@property (nonatomic,strong) NSString *avatar;//头像url
@end

@interface contactinformationTwo : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *userName;//用户名
@property (nonatomic,strong) NSString *mobile;//手机号码
@property (nonatomic,strong) NSString *contactId;//联系人iD
@end