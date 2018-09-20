//
//  TakeAndContact.h
//  jipiao
//
//  Created by Store on 16/8/31.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface contactsArry : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSMutableArray *contacts; //联系人
@end

@interface TakeAndContact : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *contactId; //联系人id
@property (nonatomic,strong) NSString *contactType; //	联系人类型
@property (nonatomic,strong) NSString *userId; //	用户id
@property (nonatomic,strong) NSString *othUserId; //	对方用户id
@property (nonatomic,strong) NSString *mobile; //	联系人电话
@property (nonatomic,strong) NSString *name; //	联系人姓名
@property (nonatomic,strong) NSString *sex; //	联系人性别
@property (nonatomic,strong) NSString *certType; //	联系人证件类型
@property (nonatomic,strong) NSString *certNo; //	联系人证件号码
@property (nonatomic,strong) NSString *birthday; //出生日期
@property (nonatomic,strong) NSString *friendFlag; //	好友标志
@property (nonatomic,strong) NSString *easemobId; //秘书环信id
@property (nonatomic,strong) NSString *avatar; //秘书头像
@end

@interface EasemobInfo : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *avatar; //	头像
@property (nonatomic,strong) NSString *nikename; //昵称
@property (nonatomic,strong) NSString *mobile; //手机号
@end

@interface universalpaymentInfo : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *prepayId; //	预支付流水号
@property (nonatomic,strong) NSString *orderId; //充值订单号
@property (nonatomic,strong) NSString *timestamp; //时间戳
@property (nonatomic,strong) NSString *nonestr; //	随机串
@property (nonatomic,strong) NSNumber *tranAmt; //交易金额
@property (nonatomic,strong) NSString *sign; //签名
@property (nonatomic,strong) NSString *orderDesc; //	订单信息描述
@property (nonatomic,strong) NSString *supportTcoin; //是否支持T币支付
@end

