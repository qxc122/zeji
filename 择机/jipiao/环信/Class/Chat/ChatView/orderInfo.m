//
//  orderInfo.m
//  jipiao
//
//  Created by Store on 16/8/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "orderInfo.h"

@implementation orderInfo
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"relationName" : @"relationName",
             @"relationMobile" : @"relationMobile",
             @"totalPrice" : @"totalPrice",
             @"refundChangeInfo" : @"refundChangeInfo",
             @"depDate" : @"depDate",
             @"depTime" : @"depTime",
             @"arrTime" : @"arrTime",
             @"depCityCode" : @"depCityCode",
             @"depCityName" : @"depCityName",
             @"arrCityCode" : @"arrCityCode",
             @"arrCityName" : @"arrCityName",
             @"depTerminal" : @"depTerminal",
             @"arrTerminal" : @"arrTerminal",
             @"flightNo" : @"flightNo",
             @"airCode" : @"airCode",
             @"airName" : @"airName",
             @"airLogo" : @"airLogo",
             @"flightModel" : @"flightModel",
             @"flyTime" : @"flyTime",
             @"stopFlag" : @"stopFlag",
             @"stopCityCode" : @"stopCityCode",
             @"stopCityName" : @"stopCityName",
             @"stopCityArrTime" : @"stopCityArrTime",
             @"lunarDepDate" : @"lunaDepDate",
             @"refundTotalPrice" : @"refundTotalPrice",
             
             @"psgInfo" : @"psgInfo",
             @"insuranceInfo" : @"insuranceInfo",
             @"priceInfo" : @"priceInfo",
             };
}
- (NSMutableArray *)psgInfo{
    if (!_psgInfo) {
        _psgInfo = [[NSMutableArray alloc] init];
    }
    return _psgInfo;
}
- (NSMutableArray *)insuranceInfo{
    if (!_insuranceInfo) {
        _insuranceInfo = [[NSMutableArray alloc] init];
    }
    return _insuranceInfo;
}
- (NSMutableArray *)priceInfo{
    if (!_priceInfo) {
        _priceInfo = [[NSMutableArray alloc] init];
    }
    return _priceInfo;
}
+(NSValueTransformer *)psgInfoJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[psgInfoData  class]];
}
+(NSValueTransformer *)insuranceInfoJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[insuranceInfoData  class]];
}
+(NSValueTransformer *)priceInfoJSONTransformer{
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:[priceInfoData  class]];
}
@end

//@implementation orderMoreData
//+(NSDictionary *)JSONKeyPathsByPropertyKey{
//    return @{
//             @"depDate" : @"depDate",
//             @"depTime" : @"depTime",
//             @"weekDate" : @"weekDate",
//             @"price" : @"price",
//             @"flightNo" : @"flightNo",
//             };
//}
//@end

@implementation insuranceInfoData
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
//             @"insuranceType" : @"insuranceType",
//             @"insuranceName" : @"insuranceName",
//             @"price" : @"price",
             @"count" : @"count",
             @"insuranceCode" : @"insuranceCode",
             };
}
@end

@implementation priceInfoData
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"priceDesc" : @"priceDesc",
             @"price" : @"price",
             @"count" : @"count",
             };
}
@end

@implementation psgInfoData
+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{
             @"refundTotalPrice" : @"refundTotalPrice",
             @"psgName" : @"psgName",
             @"psgCertType" : @"psgCertType",
             @"psgCertNo" : @"psgCertNo",
             @"psgStatus" : @"psgStatus",
             @"passengerId" : @"passengerId",
             };
}
@end

