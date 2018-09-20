//
//  orderInfo.h
//  jipiao
//
//  Created by Store on 16/8/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "HeaderTotal.h"

@class orderMoreData;

@interface orderInfo : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *relationName; //联系人名称
@property (nonatomic,strong) NSString *relationMobile; //联系人电话

@property (nonatomic,strong) NSNumber *totalPrice; //订单金额
@property (nonatomic,strong) NSString *refundChangeInfo; //退改签说明
@property (nonatomic,strong) NSString *depDate; //	出发日期
@property (nonatomic,strong) NSString *depTime; //	出发时间
@property (nonatomic,strong) NSString *arrTime; //	到达时间
@property (nonatomic,strong) NSString *depCityCode; //	出发城市
@property (nonatomic,strong) NSString *depCityName; //		出发城市名称
@property (nonatomic,strong) NSString *arrCityCode; //		抵达城市
@property (nonatomic,strong) NSString *arrCityName; //		抵达城市名称
@property (nonatomic,strong) NSString *depTerminal; //		出发航站楼
@property (nonatomic,strong) NSString *arrTerminal; //		抵达航站楼
@property (nonatomic,strong) NSString *flightNo; //		航班号
@property (nonatomic,strong) NSString *airCode; //			航司
@property (nonatomic,strong) NSString *airName; //			航司名称
@property (nonatomic,strong) NSString *airLogo; //		航司logo
@property (nonatomic,strong) NSString *flightModel; //		飞机型号
@property (nonatomic,strong) NSString *flyTime; //			飞行时间
@property (nonatomic,strong) NSString *stopFlag; //			经停标志 1-经停，0-不经停

@property (nonatomic,strong) NSString *stopCityCode; //	经停城市
@property (nonatomic,strong) NSString *stopCityName; //		经停城市名称
@property (nonatomic,strong) NSString *stopCityArrTime; //经停城市到达时间
@property (nonatomic,strong) NSString *lunarDepDate; //农历出发日期lunaDepDate
@property (nonatomic,strong) NSString *refundTotalPrice; //退款总金额


@property (nonatomic,strong) NSMutableArray *psgInfo; //乘机人信息
@property (nonatomic,strong) NSMutableArray *insuranceInfo; //保险信息
@property (nonatomic,strong) NSMutableArray *priceInfo; //金额详情
//@property (nonatomic,strong) orderMoreData *orderMore; //再定一张
@end

//@interface orderMoreData : MTLModel<MTLJSONSerializing>
//@property (nonatomic,strong) NSString *depDate; //出发日期
//@property (nonatomic,strong) NSString *depTime; //出发时间
//@property (nonatomic,strong) NSString *weekDate; //星期
//@property (nonatomic,strong) NSNumber *price; //价格
//@property (nonatomic,strong) NSString *flightNo; //航班号
//@end


@interface insuranceInfoData : MTLModel<MTLJSONSerializing>
//@property (nonatomic,strong) NSString *insuranceType; //保险类型
//@property (nonatomic,strong) NSString *insuranceName; //保险名称
//@property (nonatomic,strong) NSNumber *price; //单价
@property (nonatomic,assign) int count; //份数
@property (nonatomic,strong) NSString *insuranceCode; //保险ID
@end

@interface priceInfoData : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSString *priceDesc; //金额描述
@property (nonatomic,strong) NSNumber *price; //单价
@property (nonatomic,assign) int count; //份数
@end

@interface psgInfoData : MTLModel<MTLJSONSerializing>
@property (nonatomic,strong) NSNumber *refundTotalPrice; //退款总金额
@property (nonatomic,strong) NSString *psgName; //乘机人名字
@property (nonatomic,strong) NSString *psgCertType; //乘机人证件类型
@property (nonatomic,strong) NSString *psgCertNo; //乘机人证件号码
@property (nonatomic,strong) NSString *psgStatus; //乘机人状态乘机人状态
@property (nonatomic,assign) int passengerId; //乘机人id
@end
